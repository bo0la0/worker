import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/driver/cubit/cubit.dart';
import 'package:tourist/manager/cubit/cubit.dart';
import 'package:tourist/core/style/app_theme.dart';
import 'package:tourist/auth/cubit/auth_cubit.dart';
import 'package:tourist/tour_guide/cubit/cubit.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';

class Tourist extends StatelessWidget {
  const Tourist({Key? key, required this.startScreen}) : super(key: key);

  final Widget startScreen;

  @override
  Widget build(context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit()),
          BlocProvider(create: (_) => DriverCubit()),
          BlocProvider(create: (_) => ManagerCubit()),
          BlocProvider(create: (_) => TourGuideCubit()),
          BlocProvider(create: (_) => ServiceProviderCubit()),
        ],
        child: Sizer(
          builder: (_, _or, _dev) => MaterialApp(
            theme: appTheme,
            title: 'Tourista',
            home: startScreen,
            color: AppColors.kPrimaryColor,
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
}
