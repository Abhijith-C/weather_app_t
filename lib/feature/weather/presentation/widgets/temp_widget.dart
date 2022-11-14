import 'package:flutter/material.dart';
import 'package:weather_app/config/constants/style.dart';
import 'package:weather_app/feature/weather/model/weather_model.dart';

Wrap temp_widget(WeatherModel weather, bool tempInCel) {
  String f = ((weather.temp! - 32) * 5 / 9).toStringAsFixed(2);

  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.end,
    spacing: 8,
    children: [
      Text(
        tempInCel ? weather.temp.toString() : f,
        style: const TextStyle(
            fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      tempInCel == true
          ? const Text(
              'C',
              style: weatherUnitStye,
            )
          : const Text('F', style: weatherUnitStye)
    ],
  );
}
