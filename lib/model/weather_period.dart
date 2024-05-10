
import 'dart:convert';

import '../service/util_service.dart';
import '../config/constant.dart';

class ProbabilityOfPrecipitation {
  String unitCode;
  int? value;
  ProbabilityOfPrecipitation(this.unitCode, this.value);
  factory ProbabilityOfPrecipitation.fromJson(Map<String, dynamic> data) {
    return ProbabilityOfPrecipitation(data["unitCode"], data["value"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "unitCode": unitCode,
      "value": value
    };
  }
  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class WeatherPeriod {

  int number;
  String name;
  String startTime;
  String endTime;
  bool isDaytime;
  int temperature;
  String temperatureUnit;
  ProbabilityOfPrecipitation probabilityOfPrecipitation;
  String windSpeed;
  String windDirection;
  String shortForecast;
  String detailedForecast;

  WeatherPeriod({
    required this.number,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.probabilityOfPrecipitation,
    required this.windSpeed,
    required this.windDirection,
    required this.shortForecast,
    required this.detailedForecast
  });

  factory WeatherPeriod.fromJson(Map<String, dynamic> data) {
    return WeatherPeriod(
      number: data["number"], 
      name: data["name"], 
      startTime: data["startTime"], 
      endTime: data["endTime"], 
      isDaytime: data["isDaytime"], 
      temperature: data["temperature"], 
      temperatureUnit: data["temperatureUnit"], 
      probabilityOfPrecipitation: ProbabilityOfPrecipitation.fromJson(data["probabilityOfPrecipitation"]), 
      windSpeed: data["windSpeed"], 
      windDirection: data["windDirection"], 
      shortForecast: data["shortForecast"], 
      detailedForecast: data["detailedForecast"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "number": number,
      "name": name,
      "startTime": startTime,
      "endTime": endTime,
      "isDaytime": isDaytime,
      "temperature": temperature,
      "temperatureUnit": temperatureUnit,
      "probabilityOfPrecipitation": probabilityOfPrecipitation,
      "windSpeed": windSpeed,
      "windDirection": windDirection,
      "shortForecast": shortForecast,
      "detailedForecast": detailedForecast
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  int temperatureFahrenheit() {
    if (temperatureUnit=="F") return temperature;
    if (temperatureUnit=="C") {
      return UtilService.celciusToFahrenheit(temperature);
    }
    return 0; 
  }

  int temperatureCelcius() {
    if (temperatureUnit=="C") return temperature;
    if (temperatureUnit=="F") {
      return UtilService.fahrenheightToCelcius(temperature);
    }
    return 0; 
  }

  String detailFormatted() {
    String detail = detailedForecast;
    final a = RegExp(r'\d{1,}').allMatches(detail);
    for(final Match m in a) {
      if (detailedForecast.contains("${m[0]} mph")) {}
      else {
        int temp = int.tryParse(m[0]!) ?? 0;
        detail = detail.replaceFirst(m[0]!, "$temp F${Symbol.degress} (${UtilService.fahrenheightToCelcius(temp)} C${Symbol.degress})");
      }
    }
    return detail;
  }

}