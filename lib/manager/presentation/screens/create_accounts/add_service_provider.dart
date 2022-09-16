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
import 'package:tourist/manager/presentation/widgets/widgets.dart';

class AddServiceProviderScreen extends StatelessWidget {
  AddServiceProviderScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final balanceController = TextEditingController();
  final passwordController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceProviderCubit, ServiceProviderStates>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          AppItems.customSnackBar(context: context, text: 'Successfully');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = ServiceProviderCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text('New Service Provider'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30.sp),
                    CircleAvatar(
                      radius: 55.sp,
                      backgroundColor: Colors.transparent,
                      backgroundImage: cubit.profileImage == null
                          ? const AssetImage(AppImages.holderProfile)
                          : FileImage(File(cubit.profileImage!.path))
                              as ImageProvider,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          splashRadius: 15.sp,
                          icon: CircleAvatar(
                            radius: 20.sp,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.camera_alt,
                                color: AppColors.kPrimaryColor),
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) =>
                                ManagerItems.selectCamOrGalleryItem(
                              onPressedCam: () {
                                cubit.pickedImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              onPressedGall: () {
                                cubit.pickedImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.sp),
                    AppButtons.customTextField(
                      hintText: 'Name',
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'Phone',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'Location',
                      controller: locationController,
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customDropDownFormField(
                      hint: 'Select Category',
                      items: cubit.category,
                      margin: EdgeInsets.zero,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      onChanged: (value) => cubit.selectCategory(value),
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'Balance',
                      controller: balanceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 45.sp),
                    BuildCondition(
                      condition: state is! SignUpLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => Center(
                        child: AppButtons.customElevatedButton(
                          text: 'Submit',
                          height: 40.sp,
                          width: 200.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (cubit.profileImage != null) {
                                await cubit.signUp(
                                  context: context,
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  category: cubit.categoryValue,
                                  balance: balanceController.text,
                                  location: locationController.text,
                                  password: passwordController.text,
                                );
                              } else {
                                AppItems.customSnackBar(
                                  context: context,
                                  text: 'Most be upload image',
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 45.sp),
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
