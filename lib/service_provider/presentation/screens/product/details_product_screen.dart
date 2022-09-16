import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tourist/service_provider/data/product/product_model.dart';
import 'package:tourist/service_provider/presentation/screens/product/edit_product_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  final int index;
  final List<ProductModel> data;

  @override
  Widget build(BuildContext context) {
    var cubit = ServiceProviderCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Details'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.sp,
                width: double.infinity,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${data[index].image}'),
                  ),
                ),
              ),
              SizedBox(height: 16.sp),
              AppItems.customText('${data[index].title}', fontSize: 16.sp),
              SizedBox(height: 16.sp),
              AppItems.customText('Details'),
              SizedBox(height: 16.sp),
              AppItems.customText('${data[index].description}'),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppItems.customText('Price', fontSize: 14.sp),
                      SizedBox(height: 5.sp),
                      Container(
                        width: 70.sp,
                        height: 30.sp,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(child: Text('${data[index].price}')),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppItems.customText('Reviews', fontSize: 14.sp),
                      SizedBox(height: 15.sp),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('4.7'),
                          RatingBar.builder(
                            initialRating: 5,
                            itemSize: 13.sp,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
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
                      SizedBox(height: 5.sp),
                    ],
                  ),
                  SizedBox(width: 16.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppItems.customText('Category', fontSize: 14.sp),
                      SizedBox(height: 5.sp),
                      Container(
                        width: 70.sp,
                        height: 30.sp,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(child: Text('${data[index].category}')),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButtons.customElevatedButton(
                    text: 'Delete',
                    width: 125.sp,
                    height: 40.sp,
                    elevation: 0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    onPressed: () async =>
                        await cubit.deleteProduct('${data[index].id}'),
                  ),
                  SizedBox(width: 20.sp),
                  AppButtons.customElevatedButton(
                    text: 'Edit',
                    width: 125.sp,
                    height: 40.sp,
                    elevation: 0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryColor,
                    onPressed: () => navigateTo(
                        context, EditProductScreen(data: data, index: index)),
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
