
import 'package:basic_weather_app/model/weather_period.dart';
import 'package:basic_weather_app/service/weather_service.dart';
import 'package:basic_weather_app/config/constant.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {

  List<WeatherPeriod> periods = await WeatherService.weatherPeriods();
  for(int i = 0; i < periods.length; i++) {
    debugPrint("${periods[i].name} ${periods[i].temperatureFahrenheit()} F${Symbol.degress} ${periods[i].temperatureCelcius()} C${Symbol.degress}");
  }

}