import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:tourist/service_provider/presentation/screens/wallet/info.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({Key? key}) : super(key: key);

  final creditController = TextEditingController();

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
                CircleAvatar(
                  radius: 50.sp,
                  backgroundImage: NetworkImage('${ServiceProviderCubit.get(context).model!.image}'),
                ),
                SizedBox(height: 40.sp),
                AppButtons.customTextField(
                  hintText: 'Amount',
                  controller: creditController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 80.sp),
                AppButtons.customElevatedButton(
                  text: 'Withdraw',
                  width: 160.sp,
                  height: 40.sp,
                  onPressed: () {
                    navigateTo(context, const InfoScreen());

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
