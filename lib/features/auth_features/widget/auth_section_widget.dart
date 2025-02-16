import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/features/auth_features/logic/auth_bloc.dart';
import 'package:real_state/features/auth_features/widget/passwordfield_widget.dart';
import 'package:real_state/features/auth_features/widget/textformfield_widget.dart';
import 'package:real_state/features/profile_features/screens/profile_screen.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../screen/check_customer_type_screen.dart';

class AuthSectionWidget extends StatelessWidget {
  const AuthSectionWidget({
    super.key,
    required this.numberController,
    required this.formController,
    required this.passwordController,
  });

  final TextEditingController numberController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formController;

  @override
  Widget build(BuildContext context) {
    navigate() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => checkCustomerTypeScreen(),
        ),
      );
    }

    return Container(
      width: getAllWidth(context),
      height: getHeight(context, 0.5),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'به املاک آنلاین خوش آمدید',
                style: TextStyle(
                  fontFamily: 'sahel',
                  fontSize: 25.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.sp,
          ),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Text(
              'تلفن همراه خود را جهت احراز هویت وارد کنید',
              style: TextStyle(
                fontFamily: 'sahel',
                fontSize: 17.sp,
                color: boxColors,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.sp),
            margin: EdgeInsets.all(2.sp),
            child: Column(
              spacing: 5.sp,
              children: [
                TextFormFieldMobileWidget(
                  labelText: 'شماره همراه',
                  icon: Icon(Icons.phone_android),
                  textInputAction: TextInputAction.done,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  controller: numberController,
                  suffixIcon: null,
                ),
                PasswordFieldWidget(
                  labelText: 'رمز عبور',
                  icon: Icon(Icons.password),
                  textInputAction: TextInputAction.done,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  controller: passwordController,
                  suffixIcon: null,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              children: [
                TextButton(
                  onPressed: navigate,
                  child: Text(
                    'حساب کاربری ندارید ؟ ثبت نام کنید',
                    style: TextStyle(
                      fontFamily: 'sahel',
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(10.sp),
            margin: EdgeInsets.all(10.sp),
            width: getAllWidth(context),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      fixedSize: Size(
                        getWidth(context, 3.29),
                        getHeight(context, 0.057),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: getBorderRadiusFunc(5))),
                  onPressed: () {
                    if (formController.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            CallSignEvent(
                              numberController.text.trim(),
                              passwordController.text.trim(),
                            ),
                          );
                    }
                  },
                  child: Text(
                    'مرحله بعد',
                    style: TextStyle(
                      fontFamily: 'sahel',
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
