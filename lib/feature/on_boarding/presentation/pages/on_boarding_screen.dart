import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/config/constants/style.dart';
import 'package:weather_app/feature/on_boarding/presentation/widgets/on_boardin_screen_widget.dart';
import 'package:weather_app/feature/user_feature/presentation/pages/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController(initialPage: 0);

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (value) {
            if (value == 2) {
              setState(() {
                _visible = true;
              });
            } else {
              setState(() {
                _visible = false;
              });
            }
          },
          children: [
            OnBoardingScreenWidget(
                imgPath: 'assets/weather_images/cloud.png',
                title: 'Weather is Cloudy',
                subTitle:
                    'When the sky is cloudy, it\'s so full of clouds that you can\'t see the sun. A cloudy day isn\'t ideal for a trip to the beach, and a cloudy night isn\'t great for star gazing'),
            OnBoardingScreenWidget(
                imgPath: 'assets/weather_images/rain.png',
                title: 'Weather is Rainbow',
                subTitle:
                    'When the sky is rainbow, it\'s so full of clouds that you can\'t see the sun. A cloudy day isn\'t ideal for a trip to the beach, and a cloudy night isn\'t great for star gazing'),
            OnBoardingScreenWidget(
                imgPath: 'assets/weather_images/down.png',
                title: 'Weather is Dawn',
                subTitle:
                    'When the sky is dawn, it\'s so full of clouds that you can\'t see the sun. A cloudy day isn\'t ideal for a trip to the beach, and a cloudy night isn\'t great for star gazing')
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const SlideEffect(
                  dotColor: Colors.grey,
                  activeDotColor: themeColor,
                  dotWidth: 10,
                  dotHeight: 10),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: GestureDetector(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => LoginScreen())));
              },
              child: Container(
                height: 50,
                width: size.width,
                color: themeColor,
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
