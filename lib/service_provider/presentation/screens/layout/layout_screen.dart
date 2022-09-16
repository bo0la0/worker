import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:tourist/service_provider/cubit/states.dart';

class ServiceProviderLayout extends StatelessWidget {
  const ServiceProviderLayout({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    var cubit = ServiceProviderCubit.get(context);
    cubit.getData(id);
    cubit.getAllProducts(id);
    return BlocConsumer<ServiceProviderCubit, ServiceProviderStates>(
      listener: (context, states) {},
      builder: (context, states) {
        cubit.getAllProducts(id);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.kPrimaryColor,
            onTap: (index) => cubit.changeBottomNavBar(index),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
