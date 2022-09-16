import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/manager/cubit/cubit.dart';
import 'package:tourist/manager/cubit/states.dart';
import 'package:tourist/core/constants/constants.dart';

class ManagerLayoutScreen extends StatelessWidget {
  const ManagerLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ManagerCubit.get(context);
    cubit.tripsStats('Alex').then((value) => cubit.alx = value);
    cubit.tripsStats('Giza').then((value) => cubit.giza = value);
    cubit.tripsStats('Cairo').then((value) => cubit.cairo = value);
    cubit.tripsStats('Luxor').then((value) => cubit.luxor = value);
    cubit.tripsStats('Aswan').then((value) => cubit.aswan = value);
    cubit.tripsStats('Sharm').then((value) => cubit.sharm = value);
    return BlocConsumer<ManagerCubit, ManagerStates>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: AppColors.kPrimaryColor,
            onTap: (index) => cubit.managerChangeBottomNavBar(index),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
