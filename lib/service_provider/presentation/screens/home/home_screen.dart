import 'package:sizer/sizer.dart';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:tourist/service_provider/cubit/states.dart';
import 'package:tourist/service_provider/data/product/product_model.dart';
import 'package:tourist/service_provider/presentation/widgets/widgets.dart';
import 'package:tourist/service_provider/presentation/screens/qr/qr_code_screen.dart';
import 'package:tourist/service_provider/presentation/screens/product/add_product_screen.dart';
import 'package:tourist/service_provider/presentation/screens/product/details_product_screen.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProductModel> orders = [];
    var cubit = ServiceProviderCubit.get(context);
    var data = cubit.products;
    List<bool> isChecked = List<bool>.filled(data.length, false);
    return BlocConsumer<ServiceProviderCubit, ServiceProviderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => navigateTo(context, NewProductScreen()),
              ),
            ],
          ),
          body: data.isEmpty
              ? Center(child: AppItems.customIndicator())
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ServiceProviderItems.productItem(
                      data: data,
                      index: index,
                      value: isChecked[index],
                      onChanged: (value) {
                        cubit.selectProductChange(index, value!, isChecked);
                        if (isChecked[index] == true) {
                          orders.add(data[index]);
                        } else if (isChecked[index] == false) {
                          orders.remove(data[index]);
                        }
                      },
                      onPressedDetails: () => navigateTo(context,
                          ProductDetailsScreen(data: data, index: index)),
                    );
                  },
                ),
          floatingActionButton: orders.isEmpty
              ? Container()
              : AppButtons.customElevatedButton(
                  width: 60.sp,
                  text: 'Checkout',
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () async {
                    var id = MinId.getId();
                    var ordersList = orders.map((e) => e.toJson()).toList();
                    await cubit.addOrder(orderId: id, orders: ordersList);
                    navigateTo(context, QrCodeScreen(orderId: id));
                    orders.clear();
                  },
                ),
        );
      },
    );
  }
}
