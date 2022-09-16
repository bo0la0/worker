import 'package:flutter/material.dart';
import 'package:tourist/driver/cubit/cubit.dart';
import 'package:tourist/tour_guide/cubit/cubit.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:tourist/auth/presentation/login/login.dart';
import 'package:tourist/core/shared/local/cache_helper.dart';
import 'package:tourist/driver/presentation/screens/home/home.dart';
import 'package:tourist/tour_guide/presentation/screens/home/home.dart';
import 'package:tourist/manager/presentation/screens/layout/manager_layout.dart';
import 'package:tourist/service_provider/presentation/screens/layout/layout_screen.dart';

auth() async {
  Widget? startScreen;
  List<String> data = CacheHelper.getListOfData(key: 'UserData') ?? [];
  if (data.isEmpty) {
    startScreen = LoginScreen();
  } else {
    String id = data[0];
    String role = data[1];
    if (role == 'Driver') {
      await DriverCubit().getData(id);
      String name = await DriverCubit().getDriverName(id);
      startScreen = DriverHomeScreen(name: name);
    } else if (role == 'Manager') {
      startScreen = const ManagerLayoutScreen();
    } else if (role == 'TourGuide') {
      await TourGuideCubit().getData(id);
      String name = await TourGuideCubit().getTourGuideName(id);
      startScreen = TourGuideHomeScreen(name: name);
    } else if (role == 'ServiceProvider') {
      await ServiceProviderCubit().getAllProducts(id);
      await ServiceProviderCubit().getData(id);
      startScreen = ServiceProviderLayout(id: id);
    }
  }

  return startScreen;
}
