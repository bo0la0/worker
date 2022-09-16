import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/driver/cubit/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist/auth/cubit/auth_state.dart';
import 'package:tourist/tour_guide/cubit/cubit.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:tourist/core/shared/local/cache_helper.dart';
import 'package:tourist/driver/presentation/screens/home/home.dart';
import 'package:tourist/tour_guide/presentation/screens/home/home.dart';
import 'package:tourist/manager/presentation/screens/layout/manager_layout.dart';
import 'package:tourist/service_provider/presentation/screens/layout/layout_screen.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(SignInLoadingState());
      UserCredential userData =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );
      var id = userData.user!.uid;
      var role = userData.user!.displayName!;
      var driverCubit = DriverCubit.get(context);
      var tourCubit = TourGuideCubit.get(context);
      var proCubit = ServiceProviderCubit.get(context);
      if (role == 'Manager') {
        navigateAndFinish(context, const ManagerLayoutScreen());
        await CacheHelper.setListOfData(key: 'UserData', id: id, role: role);
      } else if (role == 'TourGuide') {
        await tourCubit.getData(id);
        String name = await tourCubit.getTourGuideName(id);
        await CacheHelper.setListOfData(key: 'UserData', id: id, role: role);
        navigateAndFinish(context, TourGuideHomeScreen(name: name));
      } else if (role == 'ServiceProvider') {
        await proCubit.getData(id);
        await proCubit.getAllProducts(id);
        await CacheHelper.setListOfData(key: 'UserData', id: id, role: role);
        navigateAndFinish(context, ServiceProviderLayout(id: id));
      } else if (role == 'Driver') {
        await driverCubit.getData(id);
        String name = await driverCubit.getDriverName(id);
        await CacheHelper.setListOfData(key: 'UserData', id: id, role: role);
        navigateAndFinish(context, DriverHomeScreen(name: name));
      }
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppItems.customSnackBar(
          context: context,
          text: 'No user found for that email.',
        );
        emit(SignInErrorState(e.code.toString()));
      } else if (e.code == 'wrong-password') {
        AppItems.customSnackBar(
          context: context,
          text: 'Wrong password provided for that user.',
        );
        emit(SignInErrorState(e.code.toString()));
      }
    }
  }
}
