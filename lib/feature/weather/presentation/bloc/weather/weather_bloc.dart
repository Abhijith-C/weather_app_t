import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/feature/weather/data/local_db/weather_db.dart';
import 'package:weather_app/feature/weather/data/remote_db/weather_remote_db.dart';
import 'package:weather_app/feature/weather/model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      emit(state.copyWith(isLoding: true));
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        final weatherData = await WeatherApiHelper.getCurrentWeather();
        await WeatherDb.saveWeather(weatherData);
        emit(WeatherState(weather: weatherData, isLoding: false));
      } else {
        final cacheWeather = await WeatherDb.getWeather();
        emit(WeatherState(weather: cacheWeather[0], isLoding: false));
      }
    });
  }
}
