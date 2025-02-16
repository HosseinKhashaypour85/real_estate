import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/shape/border_radius.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/auth_features/screen/auth_screen.dart';
import 'package:real_state/features/auth_features/screen/auth_success_screen.dart';
import 'package:real_state/features/auth_features/widget/activation_section_code_widget.dart';
import 'package:real_state/features/home_features/screen/home_screen.dart';
import 'package:real_state/features/public_features/functions/vibrate/vibrate.dart';
import 'package:real_state/features/public_features/screen/bottom_nav_screen.dart';
import 'package:real_state/features/public_features/widget/snack_bar_widget.dart';
import 'package:vibration/vibration.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      backgroundColor: primary2Color,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.sp),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'کد ارسال شده را وارد کنید ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontFamily: 'irs',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'کد ارسال شده به شماره ${widget.phoneNumber} را وارد کنید',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.sp,
                    fontFamily: 'sahel',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'تغییر شماره همراه',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.sp,
                    fontFamily: 'sahel',
                  ),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: ActivationCodeWidget(
                controllers: controllers,
              ), // مطمئن شوید متد validate در این ویجت موجود است
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  fixedSize: Size(
                    getAllWidth(context) - 10,
                    getHeight(context, 0.05),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: getBorderRadiusFunc(5),
                  ),
                ),
                onPressed: () {
                  bool isValid = controllers
                      .every((controller) => controller.text.isNotEmpty);
                  if (isValid) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthSuccessScreen(phoneNumber: widget.phoneNumber),
                      ),
                    );
                    // getSnackBarWidget(context, 'text', Colors.green);
                  } else {
                    vibrateDevice(
                        context: context, errorMsg: 'خطایی رخ داده است !');
                  }
                },
                child: Text(
                  'مرحله بعد',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'irs',
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
