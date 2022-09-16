import 'dart:io';
import 'package:intl/intl.dart';
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

class AddTripsScreen extends StatelessWidget {
  AddTripsScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final endTimeController = TextEditingController();
  final fromTimeController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final availableSeatsController = TextEditingController();
  final shortDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ManagerCubit.get(context);
    return BlocConsumer<ManagerCubit, ManagerStates>(
      listener: (context, state) {
        if (state is InsertTripSuccessState) {
          AppItems.customSnackBar(context: context, text: 'Successfully');
          Navigator.pop(context);
          cubit.closeImageSelect();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('New Trip'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
              onPressed: () {
                cubit.closeImageSelect();
                Navigator.pop(context);
              },
            ),
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
                              : const AssetImage(AppImages.holderImage1)
                                  as ImageProvider,
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
                      hintText: 'Title',
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
                    AppButtons.customDropDownFormField(
                      items: cubit.cityItems,
                      hint: 'Select City',
                      margin: EdgeInsets.zero,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      onChanged: (value) => cubit.selectCityChange(value),
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
                    AppButtons.customDropDownFormField(
                      items: cubit.allDriverNames,
                      hint: 'Select Driver Name',
                      margin: EdgeInsets.zero,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      onChanged: (value) => cubit.selectDriverNameChange(value),
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customDropDownFormField(
                      items: cubit.allTourGuideNames,
                      hint: 'Select Tour Guide Name',
                      margin: EdgeInsets.zero,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          cubit.selectTourGuidNameChange(value),
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
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      hintText: 'availableSeats',
                      controller: availableSeatsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      readOnly: true,
                      hintText: 'From Date Time',
                      controller: fromTimeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 100),
                        ).then((date) {
                          var value = DateFormat("yyyy-MM-dd").format(date!);
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((time) {
                            String timeValues =
                                value + ', ' + time!.format(context);
                            fromTimeController.text = timeValues;
                          });
                        });
                      },
                    ),
                    SizedBox(height: 10.sp),
                    AppButtons.customTextField(
                      readOnly: true,
                      hintText: 'End Date Time',
                      controller: endTimeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 100),
                        ).then((date) {
                          var value = DateFormat("yyyy-MM-dd").format(date!);
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((time) {
                            String timeValues =
                                value + ', ' + time!.format(context);
                            endTimeController.text = timeValues;
                          });
                        });
                      },
                    ),
                    SizedBox(height: 60.sp),
                    BuildCondition(
                      condition: state is! InsertTripLoadingState,
                      fallback: (_) => AppItems.customIndicator(),
                      builder: (_) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (cubit.tripImage != null) {
                              await cubit.insertTrip(
                                city: cubit.cityValue,
                                price: double.parse(priceController.text),
                                location: locationController.text,
                                endTime: endTimeController.text,
                                fromTime: fromTimeController.text,
                                description: descriptionController.text,
                                availableSeats:
                                    int.parse(availableSeatsController.text),
                                shortDescription:
                                    shortDescriptionController.text,
                              );
                            } else {
                              AppItems.customSnackBar(
                                context: context,
                                text: 'most be upload image',
                                fontColor: Colors.black,
                                backgroundColor: Colors.yellow,
                              );
                            }
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
