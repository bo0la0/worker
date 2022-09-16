import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/components/components.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tourist/manager/cubit/cubit.dart';
import 'package:tourist/manager/presentation/screens/trip/edit_trip_screen.dart';

class DetailsTripScreen extends StatelessWidget {
  const DetailsTripScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(data['image']),
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              AppItems.customText(data['shortDescription'], fontSize: 14.sp),
              SizedBox(height: 30.sp),
              AppItems.customText(
                'Details',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 5.sp),
              AppItems.customText(data['description'], fontSize: 11.sp),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      AppItems.customText(
                        'Price',
                        fontSize: 13.sp,
                      ),
                      SizedBox(height: 8.sp),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        width: 65.sp,
                        height: 35.sp,
                        child: AppItems.customText('${data['price']} LE'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppItems.customText('Reviews', fontSize: 14.sp),
                      SizedBox(height: 20.sp),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('4.7'),
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
                          const Text('1.44'),
                        ],
                      ),
                      SizedBox(height: 10.sp),
                    ],
                  ),
                  Column(
                    children: [
                      AppItems.customText(
                        'Location',
                        fontSize: 13.sp,
                      ),
                      SizedBox(height: 8.sp),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        width: 80.sp,
                        height: 35.sp,
                        child: AppItems.customText(data['city']),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButtons.customElevatedButton(
                    text: 'Delete',
                    height: 35.sp,
                    width: 90.sp,
                    color: Colors.red,
                    onPressed: ()async {
                     await ManagerCubit.get(context).deleteTrip(data['id']);
                     Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 40.sp),
                  AppButtons.customElevatedButton(
                    text: 'Edit',
                    height: 35.sp,
                    width: 90.sp,
                    onPressed: () =>
                        navigateTo(context, EditTripScreen(data: data)),
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
