import 'package:covid_statistics/src/utils/data_utils.dart';
import 'package:covid_statistics/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  double? accDefRate;
  double? accExamCnt;
  double? accExamCompCnt;
  double? careCnt;
  double? clearCnt;
  double? deathCnt;
  double? decideCnt;
  double? examCnt;
  double? resutlNegCnt;
  double? seq;
  double calcDecideCnt = 0;
  double calcExamCnt = 0;
  double calcDeathCnt = 0;
  double calcClearCnt = 0;
  String? createDt;
  DateTime? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel({
    this.accDefRate = 0,
    this.accExamCnt = 0,
    this.accExamCompCnt = 0,
    this.careCnt = 0,
    this.clearCnt = 0,
    this.deathCnt = 0,
    this.decideCnt = 0,
    this.examCnt = 0,
    this.resutlNegCnt = 0,
    this.seq = 0,
    this.createDt,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.empty() {
    return Covid19StatisticsModel();
  }

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResultDouble(xml, 'accDefRate'),
      accExamCnt: XmlUtils.searchResultDouble(xml, 'accDefRate'),
      accExamCompCnt: XmlUtils.searchResultDouble(xml, 'accExamCompCnt'),
      careCnt: XmlUtils.searchResultDouble(xml, 'careCnt'),
      clearCnt: XmlUtils.searchResultDouble(xml, 'clearCnt'),
      deathCnt: XmlUtils.searchResultDouble(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResultDouble(xml, 'decideCnt'),
      examCnt: XmlUtils.searchResultDouble(xml, 'examCnt'),
      resutlNegCnt: XmlUtils.searchResultDouble(xml, 'resutlNegCnt'),
      seq: XmlUtils.searchResultDouble(xml, 'seq'),
      createDt: XmlUtils.searchResultString(xml, 'createDt'),
      stateDt: XmlUtils.searchResultString(xml, 'stateDt') != ''
          ? DateTime.parse(XmlUtils.searchResultString(xml, 'stateDt'))
          : null,
      stateTime: XmlUtils.searchResultString(xml, 'stateTime'),
      updateDt: XmlUtils.searchResultString(xml, 'updateDt'),
    );
  }

  String get standardDayStirng => stateDt != null
      ? '${DataUtils.simpleDayFormat(stateDt!)} $stateTime 기준'
      : '검사 결과 없음';

  void updateCalcDecideCnt(double beforeCnt) {
    calcDecideCnt = decideCnt! - beforeCnt;
  }

  void updateCalcClearCnt(double beforeCnt) {
    calcClearCnt = clearCnt! - beforeCnt;
  }

  void updateCalcExamCnt(double beforeCnt) {
    calcExamCnt = examCnt! - beforeCnt;
  }

  void updateCalcDeathCnt(double beforeCnt) {
    calcDeathCnt = deathCnt! - beforeCnt;
  }
}
