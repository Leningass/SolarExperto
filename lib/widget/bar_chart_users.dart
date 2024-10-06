import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/customers/customermodel.dart';

class BarChartUsers extends StatelessWidget {
  const BarChartUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // Plots the graph
      margin: const EdgeInsets.all(0),

      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        plotOffset: -40,
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
      ),
      series: <XyDataSeries<Consumption, String>>[
        ColumnSeries<Consumption, String>(
          // Plots Columns / Bar chart
          dataLabelSettings: const DataLabelSettings(
            angle: -90,
            labelAlignment: ChartDataLabelAlignment.bottom,
            isVisible: true,
          ),
          //borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColor.yellow,
          width: 0.3,
          dataSource: const [
            Consumption(day: 'Mon', usage: 22),
            Consumption(day: 'Tue', usage: 30),
            Consumption(day: 'Wed', usage: 36),
            Consumption(day: 'Thur', usage: 19),
            Consumption(day: 'Fri', usage: 25),
            Consumption(day: 'Sat', usage: 20),
            Consumption(day: 'Sun', usage: 33),
          ],
          xValueMapper: (consumption, _) => consumption.day,
          yValueMapper: (consumption, _) => consumption.usage,
          selectionBehavior: SelectionBehavior(
            enable: true,
            selectedColor: const Color(0xFFFF5722),
            selectedOpacity: 0.6,
            unselectedOpacity: 1,
          ),
        ),
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: '',
        canShowMarker: false,
        format: 'point.x : point.y',
        textStyle: const TextStyle(
          fontFamily: 'ABeeZee',
        ),
      ),
    );
    // return BarChart(
    //   BarChartData(
    //       borderData: FlBorderData(border: Border.all(width: 0)),
    //       groupsSpace: 15,
    //       titlesData: FlTitlesData(
    //           show: true,
    //           bottomTitles: SideTitles(
    //               showTitles: true,
    //               // getTextStyles: (value) => const TextStyle(
    //               //       color: lightTextColor,
    //               //       fontWeight: FontWeight.bold,
    //               //       fontSize: 12,
    //               //     ),
    //               margin: appPadding,
    //               getTitles: (double value) {
    //                 if (value == 1) {
    //                   return 'Sun';
    //                 }
    //                 if (value == 2) {
    //                   return 'Mon';
    //                 }
    //                 if (value == 3) {
    //                   return 'Tue';
    //                 }
    //                 if (value == 4) {
    //                   return 'Wed';
    //                 }
    //                 if (value == 5) {
    //                   return 'Thr';
    //                 }
    //                 if (value == 6) {
    //                   return 'Fri';
    //                 }
    //                 if (value == 7) {
    //                   return 'Sat';
    //                 } else {
    //                   return '';
    //                 }
    //               }),
    //           leftTitles: SideTitles(
    //               showTitles: true,
    //               // getTextStyles: (value) => const TextStyle(
    //               //       color: lightTextColor,
    //               //       fontWeight: FontWeight.bold,
    //               //       fontSize: 12,
    //               //     ),
    //               margin: appPadding,
    //               getTitles: (double value) {
    //                 if (value == 1) {
    //                   return '1K';
    //                 }
    //                 if (value == 6) {
    //                   return '2K';
    //                 }
    //                 if (value == 10) {
    //                   return '3K';
    //                 }
    //                 if (value == 14) {
    //                   return '4K';
    //                 } else {
    //                   return '';
    //                 }
    //               })),
    //       barGroups: [
    //         BarChartGroupData(x: 1, barRods: [
    //           BarChartRodData(
    //               y: 10,
    //               width: 20,
    //               colors: [AppColor.yellow],
    //               borderRadius: BorderRadius.circular(5))
    //         ]),
    //         BarChartGroupData(x: 2, barRods: [
    //           BarChartRodData(
    //               y: 3,
    //               width: 20,
    //               colors: [AppColor.yellow],
    //               borderRadius: BorderRadius.circular(5))
    //         ]),
    //         BarChartGroupData(x: 3, barRods: [
    //           BarChartRodData(
    //               y: 12,
    //               width: 20,
    //               colors: [AppColor.yellow],
    //               borderRadius: BorderRadius.circular(5))
    //         ]),
    //         BarChartGroupData(x: 4, barRods: [
    //           BarChartRodData(
    //               y: 8,
    //               width: 20,
    //               colors: [AppColor.yellow],
    //               borderRadius: BorderRadius.circular(5))
    //         ]),
    //         BarChartGroupData(x: 5, barRods: [
    //           BarChartRodData(
    //               y: 6,
    //               width: 20,
    //               colors: [AppColor.yellow],
    //               borderRadius: BorderRadius.circular(5))
    //         ]),
    //         BarChartGroupData(x: 6, barRods: [
    //           BarChartRodData(
    //               y: 10,
    //               width: 20,
    //               colors: [AppColor.yellow],
    //               borderRadius: BorderRadius.circular(5))
    //         ]),
    //         BarChartGroupData(x: 7, barRods: [
    //           BarChartRodData(
    //               y: 16,
    //               width: 20,
    //               colors: [AppColor.yellow],
    //               borderRadius: BorderRadius.circular(5))
    //         ]),
    //       ]),
    // );
  }
}
