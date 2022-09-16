import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:tourist/auth/cubit/auth_cubit.dart';
import 'package:tourist/auth/cubit/auth_state.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/auth/presentation/forget/forget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8.sp),
              margin: EdgeInsets.only(top: 120.sp),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.sp),
                    AppItems.customText(
                      'Tourista',
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.kPrimaryColor,
                    ),
                    SizedBox(height: 50.sp),
                    AppButtons.customTextField(
                      hintText: 'Email',
                      controller: emailController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppButtons.customTextButton(
                        text: 'Forget Password',
                        fontSize: 11.sp,
                        color: Colors.green,
                        decoration: TextDecoration.underline,
                        onPressed: () =>
                            navigateTo(context, const ForgetPasswordScreen()),
                      ),
                    ),
                    SizedBox(height: 60.sp),
                    BuildCondition(
                      condition: state is! SignInLoadingState,
                      fallback: (_) => AppItems.customIndicator(),
                      builder: (_) => Center(
                        child: AppButtons.customElevatedButton(
                          text: 'LOGIN',
                          height: 40.sp,
                          width: 200.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await cubit.signIn(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                      ),
                    ),
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
