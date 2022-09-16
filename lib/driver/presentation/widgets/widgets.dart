import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';

class DriverItems {
  static Widget tripItem({
    required String image,
    required String endTime,
    required String fromTime,
    required String availableSeats,
    required String shortDescription,
    required Function()? onPressed,
  }) =>
      Container(
        height: 115.sp,
        width: double.infinity,
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.symmetric(horizontal: 2.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 85.sp,
                  height: 90.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
                SizedBox(width: 5.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.sp),
                    SizedBox(
                      width: 100.sp,
                      child: AppItems.customText(
                        shortDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    SizedBox(
                      width: 130.sp,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppItems.customText(
                            'From: $fromTime',
                            fontSize: 10.sp,
                            fontColor: Colors.grey,
                          ),
                          AppItems.customText(
                            'To: $endTime',
                            fontSize: 10.sp,
                            fontColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.sp),
                    AppItems.customText(availableSeats),
                    SizedBox(height: 25.sp),
                    AppButtons.customElevatedButton(
                      text: 'Details',
                      elevation: 0,
                      width: 50.sp,
                      height: 33.sp,
                      fontSize: 12.sp,
                      color: AppColors.kPrimaryColor,
                      onPressed: onPressed,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      );
}
