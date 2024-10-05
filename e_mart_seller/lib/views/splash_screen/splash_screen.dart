import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/auth_screen/login_screen.dart';
import 'package:e_mart_seller/views/splash_screen/splash_service.dart';
import 'package:e_mart_seller/views/widget_common/app_logo.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart'; // Import this if not already included

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const LoginScreen());
    });
  }

  SplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    changScreen();
    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: Center( // Center the entire body
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically center
          crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center
          children: [
            appLogoWidget(),
            10.heightBox,
            boldText(text: appname, color: white, size: 22.0),
            5.heightBox,
            "1.0.1".text.white.make(),
          ],
        ),
      ),
    );
  }
}
