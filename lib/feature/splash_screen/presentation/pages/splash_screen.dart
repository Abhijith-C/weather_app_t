import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/config/application_cache/cache_manager.dart';
import 'package:weather_app/config/constants/keys.dart';
import 'package:weather_app/config/constants/style.dart';
import 'package:weather_app/feature/on_boarding/presentation/pages/on_boarding_screen.dart';
import 'package:weather_app/feature/user_feature/presentation/pages/login_screen.dart';
import 'package:weather_app/feature/user_feature/presentation/pages/user_list_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future.delayed(const Duration(seconds: 3), (() async {
      final loginState = await Cache.readData(LOGIN_STATUS_KEY);
      final onboardingStatus = await Cache.readData(ONBOARDING_STATUS);
      if (onboardingStatus == true) {
        if (loginState == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => UserListScreen())),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => LoginScreen())),
              (route) => false);
        }
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => OnBoardingScreen())),
            (route) => false);
      }
    }));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: size.width * 0.7,
                child: Lottie.asset('assets/splash.json', fit: BoxFit.contain)),
            const Text(
              'Weather App',
              style: splashTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
