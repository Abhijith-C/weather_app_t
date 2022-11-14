// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

class WeatherState {
  bool isLoding;
  WeatherModel? weather;
  WeatherState({
    required this.isLoding,
    required this.weather,
  });

  WeatherState copyWith({
    bool? isLoding,
   WeatherModel? weather,
  }) {
    return WeatherState(
      isLoding: isLoding ?? this.isLoding,
      weather: weather ?? this.weather,
    );
  }
}

class WeatherInitial extends WeatherState {
  WeatherInitial() : super(weather: null, isLoding: false);
}
