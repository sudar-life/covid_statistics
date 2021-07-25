import 'package:covid_statistics/src/components/bar_chart.dart';
import 'package:covid_statistics/src/components/covid_statistics_viewer.dart';
import 'package:covid_statistics/src/controller/covid_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);
  late double headerTopZone;

  Widget _todayStatistics() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: CovidStatisticsViewer(
              title: '격리해제',
              addedCount: controller.todayData.calcClearCnt,
              totalCount: controller.todayData.clearCnt!,
              upDown: controller
                  .calculrateUpDown(controller.todayData.calcClearCnt),
              dense: true,
            ),
          ),
          Container(
              height: 60, child: VerticalDivider(color: Color(0xffc7c7c7))),
          Expanded(
            child: CovidStatisticsViewer(
              title: '검사 중',
              addedCount: controller.todayData.calcExamCnt,
              totalCount: controller.todayData.examCnt!,
              upDown:
                  controller.calculrateUpDown(controller.todayData.calcExamCnt),
              dense: true,
            ),
          ),
          Container(
              height: 60, child: VerticalDivider(color: Color(0xffc7c7c7))),
          Expanded(
            child: CovidStatisticsViewer(
              title: '사망자',
              addedCount: controller.todayData.calcDeathCnt,
              totalCount: controller.todayData.deathCnt!,
              upDown: controller
                  .calculrateUpDown(controller.todayData.calcDeathCnt),
              dense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _covidTrendsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "확진자 추이",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: -1,
          ),
        ),
        Obx(
          () => controller.weekDatas.isEmpty
              ? Container()
              : AspectRatio(
                  aspectRatio: 1.5,
                  child: CovidBarChart(covidDatas: controller.weekDatas),
                ),
        ),
      ],
    );
  }

  List<Widget> _backboard() {
    return [
      Positioned(
        top: 0,
        bottom: Get.size.height * 0.5,
        left: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff33656e),
                Color(0xff46818c),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        top: headerTopZone,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff195f68),
            ),
            child: Obx(
              () => Text(
                controller.todayData.standardDayStirng,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: -110,
        top: headerTopZone,
        child: Container(
          height: Get.size.height * 0.5,
          child:
              Image.asset('assets/covid_img.png', width: Get.size.width * 0.7),
        ),
      ),
      Positioned(
        right: 50,
        top: headerTopZone + 40,
        child: Obx(
          () => CovidStatisticsViewer(
            title: '확진자',
            titleColor: Colors.white,
            subValueColor: Colors.white,
            addedCount: controller.todayData.calcDecideCnt,
            totalCount: controller.todayData.decideCnt!,
            spacing: 2,
            upDown:
                controller.calculrateUpDown(controller.todayData.calcDecideCnt),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        elevation: 0,
        title: Text(
          '코로나 일별 현황',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ..._backboard(),
          Positioned(
            top: headerTopZone + 180,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      _todayStatistics(),
                      SizedBox(height: 20),
                      _covidTrendsChart(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
