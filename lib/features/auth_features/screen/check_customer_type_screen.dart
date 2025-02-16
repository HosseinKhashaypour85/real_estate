import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/shape/border_radius.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/auth_features/screen/sign_up_screen.dart';

class checkCustomerTypeScreen extends StatefulWidget {
  const checkCustomerTypeScreen({super.key});

  static const String screenId = '/signUP';

  @override
  State<checkCustomerTypeScreen> createState() =>
      _CheckCustomerTypeScreenState();
}

class _CheckCustomerTypeScreenState extends State<checkCustomerTypeScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after the widget is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigate();
    });
  }

  void navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary2Color,
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: getAllWidth(context),
                padding: EdgeInsets.all(10.sp),
                margin: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: getBorderRadiusFunc(5),
                ),
                child: Column(
                  children: [
                    Text(
                      'لطفا نوع کاربر را مشخص کنید',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'sahel',
                        fontSize: 18.sp,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        fixedSize: Size(
                          getAllWidth(context) - 10,
                          getHeight(context, 0.06),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: getBorderRadiusFunc(10),
                        ),
                      ),
                      onPressed: navigate,
                      child: Text(
                        'کاربر عادی هستم',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'irs',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: Size(
                          getAllWidth(context) - 10,
                          getHeight(context, 0.06),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: getBorderRadiusFunc(10),
                        ),
                      ),
                      onPressed: navigate,
                      child: Text(
                        ' کاربر فروشنده هستم',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'irs',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
