import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:covid_statistics/src/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  final List<Covid19StatisticsModel> covidDatas;
  CovidBarChart({Key? key, required this.covidDatas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxY = 0;
    int x = 0;
    covidDatas.forEach((element) {
      if (maxY < element.calcDecideCnt) {
        maxY = element.calcDecideCnt;
      }
    });
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY * 1.5,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 5,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                rod.y.round().toString(),
                TextStyle(color: Colors.black),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) =>
                const TextStyle(color: Color(0xff3a3a3a), fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              return DataUtils.simpleDayFormat(
                  covidDatas[value.toInt()].stateDt!);
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: this.covidDatas.map<BarChartGroupData>(
          (covidData) {
            return BarChartGroupData(
              x: x++,
              barRods: [
                BarChartRodData(
                    y: covidData.calcDecideCnt,
                    colors: [Color(0xff195f68), Color(0xff57b6c2)]),
              ],
              showingTooltipIndicators: [0],
            );
          },
        ).toList(),
      ),
    );
  }
}
