import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/manager/presentation/widgets/widgets.dart';

class ManagerReportsScreen extends StatelessWidget {
  const ManagerReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppItems.customText('Tourista'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Reports').orderBy('date',descending: true).snapshots(),
        builder: (context, snapshot) {
          var formatter =  DateFormat('yyyy-MM-dd');
          if (snapshot.hasError) {
            return Center(child: AppItems.customText('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppItems.customIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: ManagerItems.reportItem(
                        type: '${data['name']}',
                        date: formatter.format(data['date'].toDate()),
                        title: '${data['report']}',
                        description:'${data['phone']}',
                      ),
                    ),
              );
            }).toList(),
          );
        },
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(8.sp),
      //   child: ListView.separated(
      //     itemCount: 5,
      //     separatorBuilder: (context, index) => SizedBox(height: 5.sp),
      //     itemBuilder: (context, index) => ManagerItems.reportItem(
      //       type: 'Trip',
      //       date: '1/6/2022',
      //       title: 'Very Nice Trip',
      //       description:
      //           'Visit the Necropolis of Thebes and the Valley of the Kings on a full-day trip to Luxor from Cairo that includes round-trip flights, all transfers, and guided tours in Luxor. Explore ancient tombs of Egyptian pharaohs, eat lunch at a local restaurant, then walk the Avenue of Sphinxes at the Temple of Karnak. This Luxor tour is a cost-effective way to make the most of your time in Egypt, with an Egyptologist guide to help bring the ancient world to life. ',
      //     ),
      //   ),
      // ),
    );
  }
}
