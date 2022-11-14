import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/feature/weather/model/weather_model.dart';

class WeatherDb {
  static Future saveWeather(WeatherModel weather) async {
    var box = await Hive.openBox<WeatherModel>('weatherDb');
    await box.put("weather", weather);
    box.close();
  }

  static Future deleteWeather() async {
    var box = await Hive.openBox<WeatherModel>('weatherDb');
    await box.clear();
    box.close();
  }

  static Future<List<WeatherModel>> getWeather() async {
    final box = await Hive.openBox<WeatherModel>('weatherDb');
    return box.values.toList();
  }
}
