part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {}
class DeleteWeatherDb extends WeatherEvent {}