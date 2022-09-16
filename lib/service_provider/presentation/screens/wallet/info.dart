import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/components/components.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Tourista'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 70.sp),
                SizedBox(height: 40.sp),
                AppItems.customText('your withdraw request is under processing one of our customer service will call you'),
                SizedBox(height: 80.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
