import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/config/application_cache/cache_manager.dart';
import 'package:weather_app/config/constants/keys.dart';
import 'package:weather_app/config/constants/style.dart';
import 'package:weather_app/feature/user_feature/presentation/pages/user_list_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: themeColor,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.width,
              child: Lottie.asset('assets/weather.json'),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height / 1.9,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50, left: 30, bottom: 20, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '''Welcome
Back''',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                decoration:
                                    const InputDecoration(hintText: "Email"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the email';
                                  } else if (_emailController.text.trim() !=
                                      'testapp@google.com') {
                                    return 'Please enter valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      hintText: "Password"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the password';
                                    } else if (_passwordController.text
                                            .trim() !=
                                        'Test@123456') {
                                      return 'Please enter valid password';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await Cache.saveData(
                                              LOGIN_STATUS_KEY, true);
                                          await Cache.saveData(
                                              ONBOARDING_STATUS, true);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserListScreen()),
                                              (route) => false);
                                        }
                                      },
                                      child: const Text('Login')))
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
