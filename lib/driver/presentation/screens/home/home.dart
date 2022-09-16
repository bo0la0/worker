import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/driver/cubit/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/auth/presentation/login/login.dart';
import 'package:tourist/core/shared/local/cache_helper.dart';
import 'package:tourist/driver/presentation/widgets/widgets.dart';
import 'package:tourist/driver/presentation/screens/details/details.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    var cubit = DriverCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: AppItems.customText('Tourista'),
        actions: [
          AppButtons.customTextButtonWithIcon(
            text: 'Log Out',
            color: Colors.white,
            icon: Icons.logout_outlined,
            onPressed: () async {
              await cubit.signOut();
              navigateAndFinish(context, LoginScreen());
              CacheHelper.removeData(key: 'UserData');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('Trips')
              .where('driverName', isEqualTo: name)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: AppItems.customText('${snapshot.error}'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: AppItems.customIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map(
                (DocumentSnapshot doc) {
                  Map<String, dynamic> data =
                      doc.data()! as Map<String, dynamic>;
                  return DriverItems.tripItem(
                    image: data['image'],
                    endTime: '${data['endTime']}',
                    fromTime: '${data['fromTime']}',
                    shortDescription: data['shortDescription'],
                    availableSeats: '${data['availableSeats']} Tourist',
                    onPressed: () =>
                        navigateTo(context, DriverDetailsScreen(data: data)),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
