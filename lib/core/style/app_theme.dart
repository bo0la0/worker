import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist/core/constants/constants.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.kPrimaryColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
);
