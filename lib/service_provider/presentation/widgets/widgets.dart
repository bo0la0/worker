import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/data/product/product_model.dart';

class ServiceProviderItems {
  static Widget productItem({
    required int index,
    required bool value,
    required List<ProductModel> data,
    required void Function(bool?)? onChanged,
    required dynamic Function()? onPressedDetails,
  }) =>
      Container(
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.5.sp),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80.sp,
                  height: 85.sp,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.all(3.sp),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.sp)),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                    image: NetworkImage('${data[index].image}'),
                    placeholder: const AssetImage(AppImages.holderImage),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data[index].title}'),
                    SizedBox(height: 10.sp),
                    SizedBox(
                      width: 130.sp,
                      child: AppItems.customText(
                        '${data[index].description}',
                        maxLines: 3,
                        fontSize: 10.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Row(
                      children: [
                        Text('${data[index].price}'),
                        const Text(' instead of '),
                        Text('${data[index].price}'),
                      ],
                    ),
                    AppItems.ratingWidget(
                      itemSize: 13,
                      minRating: 1,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // print(rating);
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: value,
                      onChanged: onChanged,
                      activeColor: AppColors.kPrimaryColor,
                    ),
                    AppButtons.customElevatedButton(
                      text: 'Details',
                      width: 50.sp,
                      height: 35.sp,
                      fontSize: 11.sp,
                      elevation: 0,
                      onPressed: onPressedDetails,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

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

  static Widget orderItem({
    required Map<String, dynamic> data,
  }) =>
      Container(
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.5.sp),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Row(
          children: [
            Container(
              width: 80.sp,
              height: 85.sp,
              margin: EdgeInsets.all(3.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${data['orders'][0]['image']}'),
                ),
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${data['orders'][0]['title']}'),
                SizedBox(height: 10.sp),
                Text('${data['orders'][0]['price']}'),
                AppItems.ratingWidget(
                  itemSize: 13,
                  minRating: 1,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // print(rating);
                  },
                ),
              ],
            ),
          ],
        ),
      );
}
