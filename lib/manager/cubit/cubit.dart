import 'dart:io';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist/manager/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist/manager/data/model/trip/trip_model.dart';
import 'package:tourist/manager/presentation/screens/add/add_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tourist/manager/presentation/screens/feedbacks/feedback_screen.dart';
import 'package:tourist/manager/presentation/screens/reports/reports_screen.dart';
import 'package:tourist/manager/presentation/screens/home/manager_home_screen.dart';
import 'package:tourist/manager/presentation/screens/dashboard/manager_dashboard.dart';

class ManagerCubit extends Cubit<ManagerStates> {
  ManagerCubit() : super(ManagerInitialState());

  static ManagerCubit get(context) => BlocProvider.of(context);

  // ################# Handling Bottom Nav Employee #################
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_sharp),
    ),
    const BottomNavigationBarItem(
      label: 'DashBoard',
      icon: Icon(Icons.dashboard),
    ),
    const BottomNavigationBarItem(
      label: 'Reports',
      icon: Icon(Icons.report_sharp),
    ),
    const BottomNavigationBarItem(
      label: 'Feedbacks',
      icon: Icon(Icons.reviews),
    ),
    const BottomNavigationBarItem(
      label: 'Add',
      icon: Icon(Icons.add_circle),
    ),
  ];

  List<Widget> screens = [
    const ManagerHomeScreen(),
    const ManagerDashboardScreen(),
    const ManagerReportsScreen(),
    const ManagerFeedbackScreen(),
    const ManagerAddScreen(),
  ];
  void managerChangeBottomNavBar(int index) {
    currentIndex = index;
    emit(ManagerBottomNavChangeState());
  }

  Future<void> insertTrip({
    required String city,
    required double price,
    required String endTime,
    required String fromTime,
    required String location,
    required String description,
    required int availableSeats,
    required String shortDescription,
  }) async {
    emit(InsertTripLoadingState());
    final id = MinId.getId();
    var driverData = await getDriverData(driverValue);
    var tourGuideData = await getTourGuideData(tourGuideValue);
    TripModel tripModel = TripModel(
      id: id,
      city: city,
      price: price,
      location: location,
      endTime: endTime,
      fromTime: fromTime,
      description: description,
      availableSeats: availableSeats,
      driverName: driverData['name'],
      driverPhone: driverData['phone'],
      shortDescription: shortDescription,
      tourGuideName: tourGuideData!['name'],
      tourGuidePhone: tourGuideData['phone'],
      totalSeats: availableSeats,
    );
    if (tripImage != null) {
      await uploadTripImage(id);
    }
    await FirebaseFirestore.instance
        .collection('Trips')
        .doc(id)
        .set(tripModel.toJson())
        .then((value) async {
      emit(InsertTripSuccessState());
      if (tripImageUrl.isNotEmpty) {
        await setTripImage(id: id, urlImage: tripImageUrl);
      }
    }).catchError((error) {
      emit(InsertTripErrorState(error.toString()));
    });
  }

  List<String> cityItems = [
    'Cairo',
    'Alx',
    'Giza',
    'Sharm',
    'Luxor',
    'Aswan',
  ];
  var cityValue = '';
  void selectCityChange(value) {
    cityValue = value;
    emit(SelectCityChangeState());
  }

  Future<dynamic> getDriverData(String name) async {
    var docData = await FirebaseFirestore.instance
        .collection('Drivers')
        .where('name', isEqualTo: name)
        .get();
    Map<String, dynamic> data = {};
    for (var element in docData.docs) {
      data = element.data();
    }
    return data;
  }

  Future<dynamic> getTourGuideData(String name) async {
    var docData = await FirebaseFirestore.instance
        .collection('TourGuides')
        .where('name', isEqualTo: name)
        .get();
    Map<String, dynamic> data = {};
    for (var element in docData.docs) {
      data = element.data();
    }
    return data;
  }

  List<String> allDriverNames = [];
  Future getAllDriverNames() async {
    FirebaseFirestore.instance.collection('Drivers').get().then((value) {
      allDriverNames = [];
      for (var element in value.docs) {
        allDriverNames.add(element.data()['name']);
      }
    }).catchError((error) {});
  }

  String driverValue = '';
  void selectDriverNameChange(value) {
    driverValue = value;
    emit(SelectDriverNameState());
  }

  List<String> allTourGuideNames = [];
  Future getAllTourGuideNames() async {
    FirebaseFirestore.instance.collection('TourGuides').get().then((value) {
      allTourGuideNames = [];
      for (var element in value.docs) {
        allTourGuideNames.add(element.data()['name']);
      }
    }).catchError((error) {});
  }

  String tourGuideValue = '';
  void selectTourGuidNameChange(value) {
    tourGuideValue = value;
    emit(SelectTourGuideNameState());
  }

  Future<void> updateTrip({
    required String id,
    required double price,
    required String location,
    required String description,
    required int availableSeats,
    required String shortDescription,
  }) async {
    emit(UpdateTripLoadingState());
    if (tripImage != null) {
      await uploadTripImage(id);
    }
    await FirebaseFirestore.instance.collection('Trips').doc(id).set({
      'price': price,
      'city': location,
      'description': description,
      'availableSeats': availableSeats,
      'totalSeats': availableSeats,
      'shortDescription': shortDescription,
    }, SetOptions(merge: true)).then((value) async {
      emit(UpdateTripSuccessState());
      if (tripImageUrl.isNotEmpty) {
        await setTripImage(id: id, urlImage: tripImageUrl);
      }
    }).catchError((error) {
      emit(UpdateTripErrorState(error.toString()));
    });
  }

  Future<void> deleteTrip(String id) async {
    emit(DeleteTripLoadingState());
    await FirebaseFirestore.instance
        .collection('Trips')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteTripSuccessState());
    }).catchError((error) {
      emit(DeleteTripErrorState(error.toString()));
    });
  }

  int alx = 0;
  int giza = 0;
  int cairo = 0;
  int luxor = 0;
  int aswan = 0;
  int sharm = 0;
  Future<int> tripsStats(String city) async {
    emit(GetTripLoadingState());
    int length = 0;
    await FirebaseFirestore.instance
        .collection('Trips')
        .where('city', isEqualTo: city)
        .get()
        .then((value) {
      length = value.docs.length;
    });
    return length;
  }

  // ####### Handling Picked Image To Storage #######
  File? tripImage;
  Future pickedImage(ImageSource imageSource) async {
    emit(PickedTripImageLoadingState());
    final pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: imageSource,
      preferredCameraDevice: CameraDevice.front,
    );
    if (pickedFile != null) {
      tripImage = File(pickedFile.path);
      emit(PickedTripImageSuccessState());
    } else {
      emit(PickedTripImageErrorState());
    }
  }

  // ####### Handling Upload Image To Storage #######
  String tripImageUrl = '';
  Future<void> uploadTripImage(id) async {
    emit(UploadTripImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Trips/$id/${Uri.file(tripImage!.path).pathSegments.last}')
        .putFile(tripImage!)
        .then((value) async {
      tripImageUrl = await value.ref.getDownloadURL();
      emit(UploadTripImageSuccessState());
    }).catchError((error) {
      emit(UploadTripImageErrorState());
    });
  }

  // ####### Handling Set Image To FireStore #######
  Future<void> setTripImage({
    required String id,
    required String urlImage,
  }) async {
    emit(SetTripImageLoadingState());
    await FirebaseFirestore.instance
        .collection('Trips')
        .doc(id)
        .set({'image': urlImage}, SetOptions(merge: true)).then((value) {
      emit(SetTripImageSuccessState());
    }).catchError((error) {
      emit(SetTripImageErrorState(error.toString()));
    });
  }

  void closeImageSelect() {
    tripImage = null;
    emit(CloseImageState());
  }

}

