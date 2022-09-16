import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist/tour_guide/cubit/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist/tour_guide/cubit/states.dart';
import 'package:tourist/core/constants/constants.dart';
import 'package:tourist/core/components/components.dart';
import 'package:tourist/tour_guide/presentation/screens/details/group_chat_room.dart';
import 'package:tourist/tour_guide/presentation/widgets/widgets.dart';

class TourGuideDetailsScreen extends StatelessWidget {
  const TourGuideDetailsScreen({Key? key, required this.data})
      : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var cubit = TourGuideCubit.get(context);
    return BlocConsumer<TourGuideCubit, TourGuideStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: AppItems.customText('Details'),
            leading: AppButtons.customButtonBack(context),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data['image'])),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  AppItems.customText(
                    data['shortDescription'],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20.sp),
                  AppItems.customText(
                    'From: ${data['fromTime']}',
                    fontSize: 13.sp,
                  ),
                  AppItems.customText(
                    'To: ${data['endTime']}',
                    fontSize: 13.sp,
                  ),
                  AppItems.customText(
                    'Number Of Tourists: ${data['totalSeats']-data['availableSeats']}',
                    fontSize: 13.sp,
                  ),
                  AppItems.customText(
                    'Trip Location: ${data['city']}',
                    fontSize: 13.sp,
                  ),
                  SizedBox(height: 20.sp),
                  AppItems.customText(
                    'Driver Details:',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  AppItems.customText(
                    'Name: ${data['driverName']}',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  AppItems.customText(
                    'Phone: ${data['driverPhone']}',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20.sp),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Trips')
                        .doc(data['id'])
                        .collection('Tourists')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError ) {
                        return Center(
                            child: AppItems.customText('${snapshot.error}'));
                      }else if (!snapshot.hasData){
                        return Center(child: AppItems.customIndicator());
                      }
                      else{
                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs.map(
                          (DocumentSnapshot doc) {
                            Map<String, dynamic> touristData =
                                doc.data()! as Map<String, dynamic>;
                            return TourGuideItems.touristItem(
                              data: touristData,
                              onTap: () async {
                                await cubit.openUrl(
                                    context, '${touristData['location']}');
                              },
                              onChanged: (value) async {
                                await cubit.updateAttendTourist(
                                  attend: value!,
                                  tripId: data['id'],
                                  touristId: touristData['docId'],
                                );
                              },
                            );
                          },
                        ).toList(),
                      );}
                    },
                  ),
                  SizedBox(height: 43.sp),
                  Row(
                    children: [
                      SizedBox(width: 30.sp),
                      AppButtons.customElevatedButton(
                        text: 'Chat',
                        width: 80.sp,
                        height: 35.sp,
                        color: AppColors.kPrimaryColor,
                        onPressed: () {
                          navigateTo(context,GroupChatRoom(tourGuideName: data['tourGuideName'], groupChatId: data['id'], groupName: data['shortDescription'],));

                        },
                      ),
                      const Spacer(),
                      AppButtons.customElevatedButton(
                        text: 'Done',
                        width: 80.sp,
                        height: 35.sp,
                        color: AppColors.kPrimaryColor,
                        onPressed: () {

                        },
                      ),
                      SizedBox(width: 30.sp),
                    ],
                  ),
                  SizedBox(height: 30.sp),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
