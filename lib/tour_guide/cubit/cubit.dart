import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist/tour_guide/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/tour_guide/data/model/tour_guide_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class TourGuideCubit extends Cubit<TourGuideStates> {
  TourGuideCubit() : super(TourGuideInitialState());

  static TourGuideCubit get(context) => BlocProvider.of(context);

  // ============= Tour Guide Auth ===============
  Future<void> tourGuideSignUp({
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
      await user.user!.updateDisplayName('TourGuide');
      await insertTourGuideData(
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

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      emit(SignOutSuccessState());
    }).catchError((error) {
      emit(SignOutErrorState(error.toString()));
    });
  }

  Future<void> insertTourGuideData({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String location,
  }) async {
    TourGuideModel tourGuideModel = TourGuideModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      location: location,
    );
    emit(InsertTourGuideDataLoadingState());
    if (profileImage != null) {
      await uploadProfileImage(id);
    }
    await FirebaseFirestore.instance
        .collection('TourGuides')
        .doc(id)
        .set(tourGuideModel.toJson())
        .then((value) async {
      emit(InsertTourGuideDataSuccessState());
      if (profileImageUrl.isNotEmpty) {
        await setProfileImage(id: id, urlImage: profileImageUrl);
      }
    }).catchError((error) {
      emit(InsertTourGuideDataErrorState(error.toString()));
    });
  }

  TourGuideModel? tourGuideModel;
  Future<void> getData(String id) async {
    emit(GetTourGuideDataLoadingState());
    await FirebaseFirestore.instance
        .collection('TourGuides')
        .doc(id)
        .get()
        .then((value) {
      tourGuideModel = TourGuideModel.fromJson(value.data()!);
      emit(GetTourGuideDataSuccessState());
    }).catchError((error) {
      emit(GetTourGuideDataErrorState(error.toString()));
    });
  }

  Future<String> getTourGuideName(String id) async {
    String name = '';
    await FirebaseFirestore.instance
        .collection('TourGuides')
        .doc(id)
        .get()
        .then((value) {
      name = value.data()!['name'];
    }).catchError((error) {});
    return name;
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
        .child(
            'TourGuides/$id/${Uri.file(profileImage!.path).pathSegments.last}')
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
        .collection('TourGuides')
        .doc(id)
        .set({'image': urlImage}, SetOptions(merge: true)).then((value) {
      emit(SetProfileImageSuccessState());
    }).catchError((error) {
      emit(SetProfileImageErrorState(error.toString()));
    });
  }

  Future<void> updateAttendTourist({
    required bool attend,
    required String tripId,
    required String touristId,
  }) async {
    emit(UpdateAttendTouristLoadingState());
    await FirebaseFirestore.instance
        .collection('Trips')
        .doc(tripId)
        .collection('Tourists')
        .doc(touristId)
        .set({'attend': attend}, SetOptions(merge: true)).then((value) {
      emit(UpdateAttendTouristSuccessState());
    }).catchError((error) {
      emit(UpdateAttendTouristErrorState(error.toString()));
    });
  }

  Future<void> openUrl(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      AppItems.customSnackBar(
        context: context,
        text: 'Could not launch $url',
      );
    }
  }
}
