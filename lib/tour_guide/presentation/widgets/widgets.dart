import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';

class TourGuideItems {
  static Widget tripItem({
    required Map<String, dynamic> data,
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
                      image: NetworkImage(data['image']),
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
                        data['shortDescription'],
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
                            'From: ${data['fromTime']}',
                            fontSize: 10.sp,
                            fontColor: Colors.grey,
                          ),
                          AppItems.customText(
                            'To: ${data['endTime']}',
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
                    AppItems.customText('${data['availableSeats']} Tourist'),
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

  static Widget touristItem({
    required void Function()? onTap,
    required Map<String, dynamic> data,
    required void Function(bool?)? onChanged,
  }) =>
      ListTile(
        leading: CircleAvatar(
          radius: 30.sp,
          backgroundColor: AppColors.kPrimaryColor,
          backgroundImage: NetworkImage(data['image']),
        ),
        title: AppItems.customText(data['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppItems.customText(data['phone']),
            AppItems.customText('number of seats : ${data['seats']}'),
            InkWell(
              onTap: onTap,
              child: AppItems.customText(
                'Location',
                fontColor: Colors.green,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: data['attend'],
          activeColor: AppColors.kPrimaryColor,
          onChanged: onChanged,
        ),
        contentPadding: EdgeInsets.all(5.sp),
      );
}
