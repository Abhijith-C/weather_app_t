import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/config/constants/api_url.dart';
import 'package:weather_app/feature/weather/model/weather_model.dart';

class WeatherApiHelper {
  static Future<WeatherModel> getCurrentWeather() async {
    final res = await http.get(Uri.parse(weatherApiUrl));
    final weatherResponse = jsonDecode(res.body);
    final data = WeatherModel.fromJson(weatherResponse['current']);
    return data;
  }
}
