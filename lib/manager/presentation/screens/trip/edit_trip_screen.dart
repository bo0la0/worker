import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/manager/cubit/cubit.dart';
import 'package:tourist/manager/cubit/states.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/manager/presentation/widgets/widgets.dart';
import 'package:tourist/manager/presentation/screens/layout/manager_layout.dart';

class EditTripScreen extends StatelessWidget {
  EditTripScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  final formKey = GlobalKey<FormState>();
  final cityController = TextEditingController();
  final priceController = TextEditingController();
  final seatsController = TextEditingController();
  final descriptionController = TextEditingController();
  final shortDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    cityController.text = data['city'];
    priceController.text = '${data['price']}';
    descriptionController.text = data['description'];
    seatsController.text = '${data['availableSeats']}';
    shortDescriptionController.text = data['shortDescription'];

    return BlocConsumer<ManagerCubit, ManagerStates>(
      listener: (context, state) {
        if (state is UpdateTripSuccessState) {
          AppItems.customSnackBar(context: context, text: 'Successfully');
          navigateAndFinish(context, const ManagerLayoutScreen());
        }
      },
      builder: (context, state) {
        var cubit = ManagerCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Edit Trip'),
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
                          image: cubit.tripImage != null
                              ? FileImage(File(cubit.tripImage!.path))
                              : NetworkImage(data['image']) as ImageProvider,
                        ),
                      ),
                      child: Column(
                        children: [
                          if (cubit.tripImage != null)
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
                        ],
                      ),
                    ),
                    SizedBox(height: 25.sp),
                    AppButtons.customTextField(
                      hintText: 'Short Description',
                      controller: shortDescriptionController,
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
                      hintText: 'Location',
                      controller: cityController,
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
                      maxLines: 6,
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'availableSeats',
                      controller: seatsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 60.sp),
                    BuildCondition(
                      condition: state is! UpdateTripLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.updateTrip(
                              id: data['id'],
                              location: cityController.text,
                              description: descriptionController.text,
                              price: double.parse(priceController.text),
                              availableSeats: int.parse(seatsController.text),
                              shortDescription: shortDescriptionController.text,
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
