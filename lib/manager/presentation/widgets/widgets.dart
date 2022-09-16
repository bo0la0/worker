import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ManagerButtons {
  static Widget customElevatedButtonWithIcon({
    double radius = 10,
    double width = 120,
    double height = 47,
    required String text,
    required IconData icon,
    required void Function()? onPressed,
  }) =>
      ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          primary: AppColors.kPrimaryColor,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
        onPressed: onPressed,
      );
}

class ManagerItems {
  static Widget selectCamOrGalleryItem({
    required void Function()? onPressedCam,
    required void Function()? onPressedGall,
  }) =>
      AlertDialog(
        contentPadding: EdgeInsets.all(0.sp),
        content: SizedBox(
          height: 80.sp,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppButtons.customTextButtonWithIcon(
                  text: 'Gallery',
                  icon: Icons.camera,
                  color: AppColors.kPrimaryColor,
                  onPressed: onPressedGall,
                ),
                AppButtons.customTextButtonWithIcon(
                  text: 'Camera',
                  icon: Icons.camera_alt,
                  color: AppColors.kPrimaryColor,
                  onPressed: onPressedCam,
                ),
              ],
            ),
          ),
        ),
      );

  static Widget homeTripItem({
    // required String image,
    // required String title,
    // required String address,
    // required String price,
    required Map<String, dynamic> data,
    required dynamic Function()? onPressed,
  }) =>
      Card(
        margin: EdgeInsets.all(2.sp),
        child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150.sp,
                width: double.infinity,
                padding: EdgeInsets.all(5.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(data['image']),
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200.sp,
                        child: AppItems.customText(data['shortDescription']),
                      ),
                      SizedBox(height: 5.sp),
                      AppItems.customText(data['city']),
                      SizedBox(height: 5.sp),
                      AppItems.customText('${data['price']} LE'),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      RatingBar.builder(
                        initialRating: 5,
                        itemSize: 15,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // print(rating);
                        },
                      ),
                      SizedBox(height: 10.sp),
                      AppButtons.customElevatedButton(
                        text: 'more details',
                        elevation: 5.sp,
                        borderRadius: 15.sp,
                        fontSize: 8.5.sp,
                        height: 25.sp,
                        width: 38.sp,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: onPressed,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  static Widget tripItem({
    required String image,
    required String title,
    required String price,
    required Widget rating,
    required String description,
    required BuildContext context,
    required dynamic Function()? onPressedEdit,
  }) =>
      Card(
        margin: EdgeInsets.all(5.sp),
        child: Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 90.sp,
                    width: 105.sp,
                    padding: EdgeInsets.all(8.sp),
                    margin: EdgeInsets.only(left: 5.sp, top: 8.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppItems.customText(
                        title,
                        fontSize: 13.sp,
                      ),
                      SizedBox(height: 10.sp),
                      AppItems.customText(
                        description,
                        fontSize: 11.sp,
                      ),
                      SizedBox(height: 13.sp),
                      rating,
                    ],
                  ),
                  SizedBox(width: 20.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5.sp),
                      AppItems.customText(price),
                      // Checkbox(value: false, onChanged: (value) {}),
                      SizedBox(height: 10.sp),
                      AppButtons.customElevatedButton(
                        text: 'Details',
                        elevation: 0,
                        width: 70.sp,
                        height: 33.sp,
                        color: AppColors.kPrimaryColor,
                        onPressed: onPressedEdit,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  static Widget reportItem({
    required String type,
    required String date,
    required String title,
    required String description,
  }) =>
      Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.sp),
              AppItems.customText(
                'Tourist Name: $type',
                fontSize: 16.sp,
              ),
              SizedBox(height: 5.sp),
              AppItems.customText(
                title,
                fontSize: 16.sp,
              ),
              SizedBox(height: 5.sp),
              AppItems.customText(description),
              SizedBox(height: 5.sp),
              Align(
                alignment: Alignment.centerRight,
                child: AppItems.customText(
                  date,
                  fontColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
}
