import 'dart:io';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/cubit/states.dart';
import 'package:tourist/service_provider/data/product/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tourist/service_provider/data/model/service_provider_model.dart';
import 'package:tourist/service_provider/presentation/screens/home/home_screen.dart';
import 'package:tourist/service_provider/presentation/screens/order/order_screen.dart';
import 'package:tourist/service_provider/presentation/screens/profile/profile_screen.dart';

class ServiceProviderCubit extends Cubit<ServiceProviderStates> {
  ServiceProviderCubit() : super(ServiceProviderInitialState());

  static ServiceProviderCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const ProviderHomeScreen(),
    const OrdersScreen(),
    const MyAccountScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_sharp),
    ),
    const BottomNavigationBarItem(
      label: 'Orders',
      icon: Icon(Icons.shopping_cart),
    ),
    const BottomNavigationBarItem(
      label: 'My Account',
      icon: Icon(Icons.person),
    ),
  ];
  int currentIndex = 0;
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ServiceProviderBottomNavBar());
  }

  // ============= Service Provider Auth ===============
  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String balance,
    required String location,
    required String category,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(SignUpLoadingState());
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );
      await user.user!.updateDisplayName('ServiceProvider');
      await insertData(
        id: user.user!.uid,
        name: name,
        email: email,
        phone: phone,
        balance: balance,
        location: location,
        category: category,
      );
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpErrorState(e.toString()));
        AppItems.customSnackBar(
          context: context,
          text: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpErrorState(e.toString()));
        AppItems.customSnackBar(
          context: context,
          text: 'The account already exists for that email.',
        );
      }
    }
  }

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      emit(SignOutSuccessState());
    }).catchError((error) {
      emit(SignOutErrorState(error.toString()));
    });
  }

  Future<void> insertData({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String balance,
    required String location,
    required String category,
  }) async {
    ServiceProviderModel serviceProviderModel = ServiceProviderModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      balance: balance,
      category: category,
      location: location,
    );
    emit(InsertServiceProviderDataLoadingState());
    if (profileImage != null) {
      await uploadProfileImage(id);
    }
    await FirebaseFirestore.instance
        .collection('ServiceProviders')
        .doc(id)
        .set(serviceProviderModel.toJson())
        .then((value) async {
      emit(InsertServiceProviderDataSuccessState());
      if (profileImageUrl.isNotEmpty) {
        await setProfileImage(id: id, urlImage: profileImageUrl);
      }
    }).catchError((error) {
      emit(InsertServiceProviderDataErrorState(error.toString()));
    });
  }

  ServiceProviderModel? model;
  Future<void> getData(String id) async {
    emit(GetServiceProviderDataLoadingState());
    await FirebaseFirestore.instance
        .collection('ServiceProviders')
        .doc(id)
        .get()
        .then((value) {
      emit(GetServiceProviderDataSuccessState());
      model = ServiceProviderModel.fromJson(value.data()!);
    }).catchError((error) {
      emit(GetServiceProviderDataErrorState(error.toString()));
    });
  }

  // =============== Handling Picked Image To Storage ===============
  File? profileImage;
  Future pickedImage(ImageSource imageSource) async {
    emit(PickedProfileImageLoadingState());
    final pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: imageSource,
      preferredCameraDevice: CameraDevice.front,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickedProfileImageSuccessState());
    } else {
      emit(PickedProfileImageErrorState());
    }
  }

  // =============== Handling Upload Image To Storage ===============
  String profileImageUrl = '';
  Future<void> uploadProfileImage(id) async {
    emit(UploadProfileImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'ServiceProvider/$id/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      profileImageUrl = await value.ref.getDownloadURL();
      emit(UploadProfileImageSuccessState());
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // =============== Handling Set Image To FireStore ===============
  Future<void> setProfileImage({
    required String id,
    required String urlImage,
  }) async {
    emit(SetProfileImageLoadingState());
    await FirebaseFirestore.instance
        .collection('ServiceProviders')
        .doc(id)
        .set({'image': urlImage}, SetOptions(merge: true)).then((value) {
      emit(SetProfileImageSuccessState());
    }).catchError((error) {
      emit(SetProfileImageErrorState(error.toString()));
    });
  }

  // ============= Products Handling ===============
  List<String> category = [
    'Bazaar',
    'Restaurant',
    'DailyService',
    'NightService',
  ];

  var categoryValue = '';
  void selectCategory(value) {
    categoryValue = value;
    emit(SelectCategoryChangeState());
  }

  Future<void> insertProduct({
    required String title,
    required String price,
    required String category,
    required String description,
  }) async {
    final id = MinId.getId();
    ProductModel productModel = ProductModel(
      id: id,
      title: title,
      price: price,
      category: category,
      description: description,
      serviceProviderId: model!.id,
    );
    emit(InsertProductLoadingState());
    if (productImage != null) {
      await uploadProductImage(id);
    }
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(id)
        .set(productModel.toJson())
        .then((value) async {
      emit(InsertProductSuccessState());
      if (productImageUrl.isNotEmpty) {
        await setProductImage(id: id, urlImage: productImageUrl);
      }
    }).catchError((error) {
      emit(InsertProductErrorState(error.toString()));
    });
  }

  Future<void> deleteProduct(String id) async {
    emit(DeleteProductLoadingState());
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteProductSuccessState());
    }).catchError((error) {
      emit(DeleteProductErrorState(error.toString()));
    });
  }

  Future<void> updateProduct({
    required String id,
    required String title,
    required String price,
    required String category,
    required String description,
  }) async {
    emit(UpdateProductLoadingState());
    if (productImage != null) {
      await uploadProductImage(id);
    }
    await FirebaseFirestore.instance.collection('Products').doc(id).set({
      'title': title,
      'price': price,
      'category': category,
      'description': description,
    }, SetOptions(merge: true)).then((value) async {
      emit(UpdateProductSuccessState());
      if (productImageUrl.isNotEmpty) {
        await setProductImage(id: id, urlImage: productImageUrl);
      }
    }).catchError((error) {
      emit(UpdateProductErrorState(error.toString()));
    });
  }

  Future<void> addOrder({
    required String orderId,
    required List<dynamic> orders,
  }) async {
    emit(AddOrderLoadingState());
    await FirebaseFirestore.instance.collection('Orders').doc(orderId).set({
      'orderId': orderId,
      'orders': [...orders],
      'providerId': model!.id,
    }).then((value) {
      emit(AddOrderSuccessState());
    }).catchError((error) {
      emit(AddOrderErrorState(error.toString()));
    });
  }

  List<ProductModel> products = [];
  Future<void> getAllProducts(String id) async {
    emit(GetAllProductsLoadingState());
    await FirebaseFirestore.instance
        .collection('Products')
        .where('serviceProviderId', isEqualTo: id)
        .get()
        .then((value) {
      products = [];
      for (var element in value.docs) {
        products.add(ProductModel.fromJson(element.data()));
      }
      emit(GetAllProductsSuccessState());
    }).catchError((error) {
      emit(GetAllProductsErrorState(error.toString()));
    });
  }

  void selectProductChange(int index, bool value, List<bool> isChecked) {
    isChecked[index] = value;
    emit(CheckBoxChangeState());
  }

  // =============== Picked Product Image To Storage ===============
  File? productImage;
  Future pickedProductImage(ImageSource imageSource) async {
    emit(PickedProductImageLoadingState());
    final pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: imageSource,
      preferredCameraDevice: CameraDevice.front,
    );
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      emit(PickedProductImageSuccessState());
    } else {
      emit(PickedProductImageErrorState());
    }
  }

  // =============== Handling Upload Product Image To Storage ===============
  String productImageUrl = '';
  Future<void> uploadProductImage(id) async {
    emit(UploadProductImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Products/$id/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!)
        .then((value) async {
      productImageUrl = await value.ref.getDownloadURL();
      emit(UploadProductImageSuccessState());
    }).catchError((error) {
      emit(UploadProductImageErrorState());
    });
  }

  // =============== Set Product Image To FireStore ===============
  Future<void> setProductImage({
    required String id,
    required String urlImage,
  }) async {
    emit(SetProductImageLoadingState());
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(id)
        .set({'image': urlImage}, SetOptions(merge: true)).then((value) {
      emit(SetProductImageSuccessState());
    }).catchError((error) {
      emit(SetProductImageErrorState(error.toString()));
    });
  }

  void closeImageSelect() {
    productImage = null;
    emit(CloseImageSelectState());
  }

  Future<void> setProductStats({
    required String id,
    required String year,
    required String serviceProviderId,
  }) async {
    await FirebaseFirestore.instance
        .collection('Products Stats')
        .doc(year)
        .collection('Services Providers')
        .doc(serviceProviderId)
        .collection('Products')
        .doc(id)
        .set({})
        .then((value) {})
        .catchError((error) {});
  }
}
