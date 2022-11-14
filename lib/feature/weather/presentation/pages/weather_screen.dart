import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/config/application_cache/cache_manager.dart';
import 'package:weather_app/config/constants/keys.dart';
import 'package:weather_app/config/constants/style.dart';
import 'package:weather_app/feature/user_feature/presentation/pages/login_screen.dart';
import 'package:weather_app/feature/weather/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/feature/weather/presentation/widgets/temp_widget.dart';

class WeatherScreen extends StatefulWidget {
  bool tempInCel;
  WeatherScreen({Key? key, required this.tempInCel}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    print('1234 ${widget.tempInCel}');
    // TODO: implement initState
    super.initState();
    context.read<WeatherBloc>().add(GetWeather());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Today Weather'),
        actions: [
          IconButton(
              onPressed: () async {
                await Cache.saveData(LOGIN_STATUS_KEY, false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          color: themeColor,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state.isLoding == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return state.weather == null
                    ? const SizedBox()
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            temp_widget(state.weather!, widget.tempInCel),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.weather!.weather![0].main.toString(),
                              style: weatherSubTitleStyle,
                            ),
                            SizedBox(
                              height: size.height * 0.3,
                            ),
                            Text(
                              'Humidity : ${state.weather!.humidity.toString()}',
                              style: weatherSubTitleStyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Wind Speed : ${state.weather!.windSpeed.toString()}',
                              style: weatherSubTitleStyle,
                            )
                          ],
                        ),
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
