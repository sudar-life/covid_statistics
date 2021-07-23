import 'package:covid_statistics/src/controller/covid_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends GetView<CovidStatisticsController> {
  const App({Key? key}) : super(key: key);

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            " : $value",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('코로나 일별 현황'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          var info = controller.covidStatistic.value;
          return Column(
            children: [
              infoWidget("기준일", info.stateDt ?? ''),
              infoWidget("기준시간", info.stateTime ?? ''),
              infoWidget("확진자 수", info.decideCnt ?? ''),
              infoWidget("검사진행 수", info.examCnt ?? ''),
              infoWidget("사망자 수", info.deathCnt ?? ''),
              infoWidget("치료중 환자 수", info.careCnt ?? ''),
              infoWidget("결과 음성 수", info.resutlNegCnt ?? ''),
              infoWidget("누적 검사 수", info.accExamCnt ?? ''),
              infoWidget("누적 검사 완료 수", info.accExamCompCnt ?? ''),
              infoWidget("누적 확진률", info.accDefRate ?? ''),
            ],
          );
        }),
      ),
    );
  }
}
