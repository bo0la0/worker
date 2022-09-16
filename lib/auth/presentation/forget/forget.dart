import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AppItems.customText(
                'TOURISTA',
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                fontColor: AppColors.kPrimaryColor,
              ),
            ),
            SizedBox(height: 60.sp),
            Container(
              height: 150.sp,
              width: double.infinity,
              margin: EdgeInsets.all(10.sp),
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(),
              ),
              child: Column(
                children: [
                  AppItems.customText(
                    'one of our customer service will contact you soon ...',
                    fontSize: 16.sp,
                  ),
                  SizedBox(height: 50.sp),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: AppButtons.customElevatedButton(
                      text: 'Ok',
                      width: 80.sp,
                      height: 35.sp,
                      color: AppColors.kPrimaryColor,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
