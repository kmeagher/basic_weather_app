
import '../model/api_response.dart';
import './http_service.dart';
import '../model/weather_period.dart';

const String weatherApiDomain = "api.weather.gov";

class WeatherService {

  static Future<ApiResponse> indianapolis() async {
    return await HttpService.getRequest("gridpoints/IND/53,70/forecast", protocol: Protocol.https, domain: weatherApiDomain); 
  }

  static Future<List<WeatherPeriod>> weatherPeriods({ApiResponse? response}) async {
    response ??= await indianapolis();
    if (response.data.isNotEmpty) {
      Map<String, dynamic> data = response.data[0];
      Map<String, dynamic> properties = data["properties"];
      List<dynamic> raw = properties["periods"];
      return raw.map((dynamic period) => WeatherPeriod.fromJson(period)).toList();
    }
    return [];  
  }

}