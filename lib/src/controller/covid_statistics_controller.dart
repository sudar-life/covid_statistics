import 'package:covid_statistics/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:covid_statistics/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel?> _todayData = Covid19StatisticsModel().obs;
  Rx<Covid19StatisticsModel?> _yesterDayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> weekDatas = <Covid19StatisticsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async {
    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(Duration(days: 8)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var result = await _covidStatisticsRepository.fetchCovid19Statistics(
        startDate: startDate, endDate: endDate);
    if (result.isNotEmpty && result.length > 1) {
      for (var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].updateCalcDecideCnt(result[i + 1].decideCnt!);
          result[i].updateCalcClearCnt(result[i + 1].clearCnt!);
          result[i].updateCalcDeathCnt(result[i + 1].deathCnt!);
          result[i].updateCalcExamCnt(result[i + 1].examCnt!);
        }
      }
      weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _todayData(result.first);
      _yesterDayData(result[1]);
    }
  }

  Covid19StatisticsModel get todayData =>
      _todayData.value ?? Covid19StatisticsModel.empty();
  Covid19StatisticsModel get yesterDayData =>
      _yesterDayData.value ?? Covid19StatisticsModel.empty();

  double calculrateValue(double todayValue, double yesterValue) {
    return (todayValue - yesterValue).abs();
  }

  ArrowDirection calculrateUpDown(double value) {
    if (value == 0) {
      return ArrowDirection.MIDDLE;
    } else if (value > 0) {
      return ArrowDirection.UP;
    } else {
      return ArrowDirection.DOWN;
    }
  }
}
