import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:tourist/auth/presentation/login/login.dart';
import 'package:tourist/core/shared/local/cache_helper.dart';
import 'package:tourist/service_provider/presentation/screens/layout/layout_screen.dart';
import 'package:tourist/service_provider/presentation/screens/wallet/wallet_screen.dart';
import 'package:tourist/service_provider/presentation/screens/dashboard/dashboard_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = ServiceProviderCubit.get(context);
    var model = cubit.model;
    return RefreshIndicator(
      color: AppColors.kPrimaryColor,
      onRefresh: () {
        setState(() {});
        return cubit.getData(model!.id!);
      },
      child: ListView(
        children: [
          Container(
            width: 270.sp,
            height: 190.sp,
            color: AppColors.kPrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60.sp,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(model!.image!),
                ),
                SizedBox(height: 5.sp),
                AppItems.customText(
                  model.name!,
                  fontSize: 13.sp,
                  fontColor: Colors.white,
                ),
                AppItems.customText(
                  model.email!,
                  fontSize: 13.sp,
                  fontColor: Colors.white,
                ),
                AppItems.customText(
                  'Balance: ${model.balance}',
                  fontSize: 13.sp,
                  fontColor: Colors.white,
                ),
              ],
            ),
          ),
          AppItems.customListTile(
            title: 'Home',
            icon: Icons.home,
            onTap: () =>
                navigateTo(context, const ServiceProviderLayout(id: '')),
          ),
          AppItems.customDividerProfile(),
          AppItems.customListTile(
            title: 'Dashboard',
            icon: Icons.dashboard,
            onTap: () => navigateTo(context, DashboardScreen()),
          ),
          AppItems.customDividerProfile(),
          AppItems.customListTile(
            title: 'Wallet',
            icon: Icons.account_balance_wallet_outlined,
            onTap: () => navigateTo(context, WalletScreen()),
          ),
          AppItems.customDividerProfile(),
          AppItems.customListTile(
            title: 'Logout',
            icon: Icons.logout,
            onTap: () {
              navigateAndFinish(context, LoginScreen());
              CacheHelper.removeData(key: 'UserData');
            },
          ),
          AppItems.customDividerProfile(),
        ],
      ),
    );
  }
}
