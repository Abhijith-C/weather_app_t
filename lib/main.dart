import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/feature/user_feature/presentation/bloc/user/user_bloc.dart';
import 'package:weather_app/feature/weather/model/weather_model.dart';
import 'package:weather_app/feature/weather/presentation/bloc/weather/weather_bloc.dart';
import 'config/application_cache/cache_manager.dart';
import 'config/constants/keys.dart';
import 'feature/splash_screen/presentation/pages/splash_screen.dart';
import 'feature/user_feature/model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  if (!Hive.isAdapterRegistered(WeatherModelAdapter().typeId)) {
    Hive.registerAdapter(WeatherModelAdapter());
  }
  if (!Hive.isAdapterRegistered(WeatherAdapter().typeId)) {
    Hive.registerAdapter(WeatherAdapter());
  }

  final loginStatus = await Cache.readData(LOGIN_STATUS_KEY);
  final onboarding = await Cache.readData(ONBOARDING_STATUS);
  if (loginStatus == null && onboarding == null) {
    await Cache.saveData(LOGIN_STATUS_KEY, false);
    await Cache.saveData(ONBOARDING_STATUS, false);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
