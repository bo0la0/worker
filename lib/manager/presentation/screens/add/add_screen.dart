import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/manager/cubit/cubit.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/manager/presentation/widgets/widgets.dart';
import 'package:tourist/manager/presentation/screens/trip/add_trip_screen.dart';
import 'package:tourist/manager/presentation/screens/create_accounts/add_driver.dart';
import 'package:tourist/manager/presentation/screens/create_accounts/add_tour_guide.dart';
import 'package:tourist/manager/presentation/screens/create_accounts/add_service_provider.dart';

class ManagerAddScreen extends StatelessWidget {
  const ManagerAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ManagerCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tourista'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ManagerButtons.customElevatedButtonWithIcon(
              text: 'New Trip',
              width: 160.sp,
              icon: Icons.add_circle_outline,
              onPressed: () async {
                await cubit.getAllDriverNames();
                await cubit.getAllTourGuideNames();
                navigateTo(context, AddTripsScreen());
              },
            ),
            SizedBox(height: 20.sp),
            ManagerButtons.customElevatedButtonWithIcon(
              text: 'New Driver',
              width: 160.sp,
              icon: Icons.add_circle_outline,
              onPressed: () => navigateTo(context, AddDriverScreen()),
            ),
            SizedBox(height: 20.sp),
            ManagerButtons.customElevatedButtonWithIcon(
              text: 'New Tour Guide',
              width: 160.sp,
              icon: Icons.add_circle_outline,
              onPressed: () => navigateTo(context, AddTourGuideScreen()),
            ),
            SizedBox(height: 20.sp),
            ManagerButtons.customElevatedButtonWithIcon(
              text: 'New Service Provider',
              width: 160.sp,
              icon: Icons.add_circle_outline,
              onPressed: () => navigateTo(context, AddServiceProviderScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
