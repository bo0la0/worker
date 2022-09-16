import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist/driver/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/driver/data/models/driver/driver_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DriverCubit extends Cubit<DriverStates> {
  DriverCubit() : super(DriverInitialState());

  static DriverCubit get(context) => BlocProvider.of(context);

  // ============= Driver Auth ===============
  Future<void> driverSignUp({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(SignUpLoadingState());
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await user.user!.updateDisplayName('Driver');
      await insertDriverData(
        id: user.user!.uid,
        name: name,
        email: email,
        phone: phone,
        location: location,
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

  Future<void> insertDriverData({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String location,
  }) async {
    DriverModel driverModel = DriverModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      location: location,
    );
    emit(InsertDriverDataLoadingState());
    if (profileImage != null) {
      await uploadProfileImage(id);
    }
    await FirebaseFirestore.instance
        .collection('Drivers')
        .doc(id)
        .set(driverModel.toJson())
        .then((value) async {
      emit(InsertDriverDataSuccessState());
      if (profileImageUrl.isNotEmpty) {
        await setProfileImage(id: id, urlImage: profileImageUrl);
      }
    }).catchError((error) {
      emit(InsertDriverDataErrorState(error.toString()));
    });
  }

  DriverModel? driverModel;
  Future<void> getData(String id) async {
    emit(GetDriverDataLoadingState());
    await FirebaseFirestore.instance
        .collection('Drivers')
        .doc(id)
        .get()
        .then((value) {
      emit(GetDriverDataSuccessState());
      driverModel = DriverModel.fromJson(value.data()!);
    }).catchError((error) {
      emit(GetDriverDataErrorState(error.toString()));
    });
  }

  Future<String> getDriverName(String id) async {
    String name = '';
    await FirebaseFirestore.instance
        .collection('Drivers')
        .doc(id)
        .get()
        .then((value) {
      name = value.data()!['name'];
    }).catchError((error) {});
    return name;
  }

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      emit(SignOutSuccessState());
    }).catchError((error) {
      emit(SignOutErrorState(error.toString()));
    });
  }

// ####### Handling Picked Image To Storage #######
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

  // ####### Handling Upload Image To Storage #######
  String profileImageUrl = '';
  Future<void> uploadProfileImage(id) async {
    emit(UploadProfileImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Drivers/$id/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      profileImageUrl = await value.ref.getDownloadURL();
      emit(UploadProfileImageSuccessState());
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // ####### Handling Set Image To FireStore #######
  Future<void> setProfileImage({
    required String id,
    required String urlImage,
  }) async {
    emit(SetProfileImageLoadingState());
    await FirebaseFirestore.instance
        .collection('Drivers')
        .doc(id)
        .set({'image': urlImage}, SetOptions(merge: true)).then((value) {
      emit(SetProfileImageSuccessState());
    }).catchError((error) {
      emit(SetProfileImageErrorState(error.toString()));
    });
  }

  bool isChecked = false;
  void changeCheckBox(value) {
    emit(ChangeCheckBoxState());
    isChecked = value;
  }
}
