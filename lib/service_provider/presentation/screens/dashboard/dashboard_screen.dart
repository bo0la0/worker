import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tourist/core/components/components.dart';

class SubscriberSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;

  SubscriberSeries({
    required this.year,
    required this.subscribers,
    required this.barColor,
  });
}

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final List<SubscriberSeries> data = [
    SubscriberSeries(
      year: "BigTasty",
      subscribers: 10000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.amberAccent),
    ),
    SubscriberSeries(
      year: "ShareBox",
      subscribers: 11000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.teal),
    ),
    SubscriberSeries(
      year: " Mac",
      subscribers: 12000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    SubscriberSeries(
      year: "ChickenMac",
      subscribers: 10000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.orange),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        elevation: 0,
        title: const Text('Dashboard'),
        leading: AppButtons.customButtonBack(context),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.sp),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5.sp),
            child: Column(
              children: <Widget>[
                Text(
                  "Requests",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Expanded(
                  child: charts.BarChart(series, animate: true),
                ),
                SizedBox(width: 10.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
