import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/driver/cubit/cubit.dart';
import 'package:tourist/driver/cubit/states.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/manager/presentation/widgets/widgets.dart';

class AddDriverScreen extends StatelessWidget {
  AddDriverScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverCubit, DriverStates>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          AppItems.customSnackBar(context: context, text: 'Successfully');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = DriverCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text('New Driver'),
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
                              await cubit.driverSignUp(
                                context: context,
                                name: nameController.text,
                                phone: phoneController.text,
                                email:
                                    emailController.text.trim().toLowerCase(),
                                location: locationController.text,
                                password: passwordController.text,
                              );
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
