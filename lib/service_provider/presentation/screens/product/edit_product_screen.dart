import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:tourist/service_provider/cubit/states.dart';
import 'package:tourist/service_provider/data/product/product_model.dart';
import 'package:tourist/service_provider/presentation/widgets/widgets.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  final int index;
  final List<ProductModel> data;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = '${data[index].title}';
    priceController.text = '${data[index].price}';
    categoryController.text = '${data[index].category}';
    descriptionController.text = '${data[index].description}';

    return BlocConsumer<ServiceProviderCubit, ServiceProviderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ServiceProviderCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Edit Product'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150.sp,
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: cubit.productImage != null
                              ? FileImage(File(cubit.productImage!.path))
                              : NetworkImage('${data[index].image}')
                                  as ImageProvider,
                        ),
                      ),
                      child: Column(
                        children: [
                          if (cubit.productImage != null)
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => cubit.closeImageSelect(),
                            ),
                          const Spacer(),
                          IconButton(
                            icon: CircleAvatar(
                              radius: 20.sp,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.camera_alt,
                                color: AppColors.kPrimaryColor,
                                size: 20.sp,
                              ),
                            ),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) =>
                                  ServiceProviderItems.selectCamOrGalleryItem(
                                onPressedCam: () {
                                  cubit.pickedProductImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                onPressedGall: () {
                                  cubit.pickedProductImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.sp),
                    AppButtons.customTextField(
                      hintText: 'Title',
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'Price',
                      controller: priceController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'Category',
                      controller: categoryController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'Description',
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 60.sp),
                    BuildCondition(
                      condition: state is! InsertProductLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.updateProduct(
                              id: '${data[index].id}',
                              title: titleController.text,
                              price: priceController.text,
                              category: categoryController.text,
                              description: descriptionController.text,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.sp),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
