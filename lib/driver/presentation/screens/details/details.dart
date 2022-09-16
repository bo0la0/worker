import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/driver/cubit/cubit.dart';
import 'package:tourist/driver/cubit/states.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';

class DriverDetailsScreen extends StatelessWidget {
  const DriverDetailsScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverCubit, DriverStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: AppItems.customText('Details'),
          leading: AppButtons.customButtonBack(context),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 150.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(data['image'])),
                  ),
                ),
                SizedBox(height: 20.sp),
                AppItems.customText(
                  data['shortDescription'],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 20.sp),
                AppItems.customText(
                  'From: ${data['fromTime']}',
                  fontSize: 12.sp,
                ),
                AppItems.customText(
                  'To: ${data['endTime']}',
                  fontSize: 12.sp,
                ),
                AppItems.customText(
                  'Number Of Tourists: ${data['totalSeats'] - data['availableSeats']}',
                  fontSize: 12.sp,
                ),
                AppItems.customText(
                  'Trip Location: ${data['city']}',
                  fontSize: 12.sp,
                ),
                SizedBox(height: 20.sp),
                AppItems.customText(
                  'Tour Guide Details:',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                AppItems.customText(
                  'Name: ${data['tourGuideName']}',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
                AppItems.customText(
                  'Phone: ${data['tourGuidePhone']}',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 30.sp),
                Row(
                  children: [
                    SizedBox(width: 30.sp),
                    const Spacer(),
                    AppButtons.customElevatedButton(
                      text: 'Done',
                      width: 80.sp,
                      height: 35.sp,
                      color: AppColors.kPrimaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 30.sp),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
