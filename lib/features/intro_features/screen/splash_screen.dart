import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/shape/border_radius.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/features/intro_features/screen/intro_screen.dart';
import 'package:real_state/features/public_features/functions/pref/shared_pref.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../public_features/screen/bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String screenId = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateFunc() {
    Timer(
      Duration(seconds: 3),
      () async {
        if (await SharedPref().getIntroStatus()) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavScreen.screenId,
            (route) => false,
          );
        } else{
          Navigator.pushReplacementNamed(context, IntroScreen.screenId);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    navigateFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInUp(
              child: Image.asset(
                'assets/images/logo2.png',
                width: getWidth(context, 0.7),
              ),
            ),
            TextButton(
              onPressed: () async {
                final url = 'https://hosseinkhashaypour.ir';
                if (await canLaunchUrlString(url)) {
                  launchUrlString(url);
                }
              },
              child: Text(
                'www.hosseinkhashaypour.ir',
                style: TextStyle(
                  fontFamily: 'sahel',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
