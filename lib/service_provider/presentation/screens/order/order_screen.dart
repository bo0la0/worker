import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/service_provider/cubit/cubit.dart';
import 'package:tourist/service_provider/presentation/widgets/widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ServiceProviderCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Orders')
            .where('providerId', isEqualTo: cubit.model!.id)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppItems.customIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return ServiceProviderItems.orderItem(data: data);
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
