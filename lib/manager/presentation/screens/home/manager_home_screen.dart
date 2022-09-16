import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/auth/presentation/login/login.dart';
import 'package:tourist/core/shared/local/cache_helper.dart';
import 'package:tourist/manager/presentation/widgets/widgets.dart';
import 'package:tourist/manager/presentation/screens/trip/details_trip_screen.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppItems.customText('Tourista'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          Container(
            width: 250.sp,
            height: 170.sp,
            color: AppColors.kPrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.sp,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage(AppImages.tourist),
                ),
              ],
            ),
          ),
          AppItems.customListTile(
            title: 'Home',
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          AppItems.customDividerProfile(),
          AppItems.customListTile(
            title: 'Trips',
            icon: Icons.trip_origin_outlined,
            onTap: () => Navigator.pop(context),
          ),
          AppItems.customDividerProfile(),
          AppItems.customListTile(
            title: 'log out',
            icon: Icons.logout,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              navigateAndFinish(context, LoginScreen());
              CacheHelper.removeData(key: 'UserData');
            },
          ),
          AppItems.customDividerProfile(),
        ],
      )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Trips').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: AppItems.customText('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppItems.customIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return ManagerItems.homeTripItem(
                data: data,
                onPressed: () =>
                    navigateTo(context, DetailsTripScreen(data: data)),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
