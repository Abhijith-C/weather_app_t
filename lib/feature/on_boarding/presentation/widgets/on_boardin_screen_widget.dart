// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather_app/config/constants/constants.dart';
import 'package:weather_app/config/constants/style.dart';

class OnBoardingScreenWidget extends StatelessWidget {
  String imgPath;
  String title;
  String subTitle;
  OnBoardingScreenWidget({
    Key? key,
    required this.imgPath,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: themeColor,
      child: Stack(children: [
        Positioned(
          top: size.height * 0.2,
          child: SizedBox(
            height: size.width / 1.5,
            width: size.width,
            child: Image.asset(imgPath),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: size.height / 3,
            width: size.width,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  subTitle,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
