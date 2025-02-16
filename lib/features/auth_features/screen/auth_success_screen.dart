import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/auth_features/screen/auth_screen.dart';

class AuthSuccessScreen extends StatefulWidget {
  const AuthSuccessScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<AuthSuccessScreen> createState() => _AuthSuccessScreenState();
}

class _AuthSuccessScreenState extends State<AuthSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary2Color,
      body: Center(
        child: Column(
          spacing: 10.sp,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/success.png',
              width: getWidth(context, 0.7),
            ),
            Text(
              'ثبت نام شماره ${widget.phoneNumber} با موفقیت انجام شد',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'irs',
                fontSize: 16.sp,
              ),
            ),
            Text(
              'از پنل کاربری اقدام به ورود به پنل بکنید !',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'irs',
                fontSize: 16.sp,
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                fixedSize: Size(
                  getAllWidth(context) - 10,
                  getHeight(context, 0.05),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              },
              child: Text(
                'بازگشت',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'irs',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
