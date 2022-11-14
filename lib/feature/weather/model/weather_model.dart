import 'package:hive_flutter/hive_flutter.dart';
part 'weather_model.g.dart';

@HiveType(typeId: 2)
class WeatherModel {
  @HiveField(0)
  int? dt;
  @HiveField(1)
  int? sunrise;
  @HiveField(2)
  int? sunset;
  @HiveField(3)
  double? temp;
  @HiveField(4)
  double? feelsLike;
  @HiveField(5)
  int? pressure;
  @HiveField(6)
  int? humidity;
  @HiveField(7)
  double? dewPoint;
  @HiveField(8)
  int? uvi;
  @HiveField(9)
  int? clouds;
  @HiveField(10)
  int? visibility;
  @HiveField(11)
  double? windSpeed;
  @HiveField(12)
  int? windDeg;
  @HiveField(13)
  List<Weather>? weather;

  WeatherModel(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.weather});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['uvi'] = uvi;
    data['clouds'] = clouds;
    data['visibility'] = visibility;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 3)
class Weather {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? main;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}
