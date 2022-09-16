import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:tourist/manager/cubit/cubit.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tourist/core/components/components.dart';

class SubscriberSeries {
  final String year;
  final dynamic subscribers;
  final charts.Color barColor;

  SubscriberSeries({
    required this.year,
    required this.subscribers,
    required this.barColor,
  });
}

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SubscriberSeries> data = [
      SubscriberSeries(
        year: "Cairo",
        subscribers: ManagerCubit.get(context).cairo,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      SubscriberSeries(
        year: "Giza",
        subscribers: ManagerCubit.get(context).giza,
        barColor: charts.ColorUtil.fromDartColor(Colors.amberAccent),
      ),
      SubscriberSeries(
        year: "Alex",
        subscribers: ManagerCubit.get(context).alx,
        barColor: charts.ColorUtil.fromDartColor(Colors.teal),
      ),
      SubscriberSeries(
        year: "luxor",
        subscribers: ManagerCubit.get(context).luxor,
        barColor: charts.ColorUtil.fromDartColor(Colors.deepOrange),
      ),
      SubscriberSeries(
        year: " Sharm",
        subscribers: ManagerCubit.get(context).sharm,
        barColor: charts.ColorUtil.fromDartColor(Colors.amber),
      ),
      SubscriberSeries(
        year: "aswan",
        subscribers: ManagerCubit.get(context).aswan,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange),
      ),
    ];
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
        id: "Subscribers",
        data: data,
        domainFn: (series, _) => series.year,
        colorFn: (series, _) => series.barColor,
        measureFn: (series, _) => series.subscribers,
      ),
    ];
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
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.sp),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5.sp),
            child: Column(
              children: <Widget>[
                const Text("Requests"),
                Expanded(child: charts.BarChart(series, animate: true)),
                SizedBox(width: 10.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
