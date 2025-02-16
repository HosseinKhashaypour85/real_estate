import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/auth_features/logic/auth_bloc.dart';
import 'package:real_state/features/auth_features/screen/phone_auth_screen.dart';
import 'package:real_state/features/auth_features/services/auth_api_repository.dart';
import 'package:real_state/features/auth_features/widget/passwordfield_widget.dart';
import 'package:real_state/features/auth_features/widget/textformfield_widget.dart';
import 'package:real_state/features/public_features/functions/secure_storage/secure_storage.dart';
import 'package:real_state/features/public_features/widget/snack_bar_widget.dart';

import '../../../const/shape/border_radius.dart';
import '../../public_features/functions/vibrate/vibrate.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String screenId = '/signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isShowUse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary2Color,
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              height: 120.sp,
              color: primaryColor,
            ),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              AuthApiRepository(),
            ),
            child: BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is SignUpLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                return Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo2.png',
                          width: getWidth(context, 0.7),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: TextFormFieldMobileWidget(
                            labelText: 'شماره موبایل',
                            icon: Icon(
                              Icons.phone_android,
                            ),
                            textInputAction: TextInputAction.done,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            controller: phoneNumController,
                            suffixIcon: null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: PasswordFieldWidget(
                            labelText: 'رمز عبور',
                            icon: Icon(
                              Icons.password,
                            ),
                            textInputAction: TextInputAction.done,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            controller: passwordController,
                            suffixIcon: null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: PasswordFieldWidget(
                            labelText: 'تایید رمز عبور',
                            icon: Icon(
                              Icons.password,
                            ),
                            textInputAction: TextInputAction.done,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            controller: passwordConfirmController,
                            suffixIcon: null,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              focusColor: primaryColor,
                              activeColor: primaryColor,
                              hoverColor: primaryColor,
                              checkColor: Colors.white,
                              value: isShowUse,
                              onChanged: (value) {
                                setState(() {
                                  isShowUse = !isShowUse;
                                });
                              },
                            ),
                            Text(
                              'قوانین املاک آنلاین رو میپذیرم',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'sahel',
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              fixedSize: Size(
                                getWidth(context, 3.29),
                                getHeight(context, 0.057),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: getBorderRadiusFunc(5),
                              ),
                            ),
                            onPressed: () {
                              if (!isShowUse) {
                                vibrateDevice(context: context , errorMsg: 'شما قوانین را نپذیرفته اید');
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'خطا !',
                                      style: TextStyle(
                                        fontFamily: 'irs',
                                      ),
                                    ),
                                    content: const Text(
                                      'شما قوانین را نپذیرفته‌اید !',
                                      style: TextStyle(
                                        fontFamily: 'sahel',
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'برگشت',
                                          style: TextStyle(
                                            fontFamily: 'irs',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }

                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  CallSignUpEvent(
                                    phoneNumber: phoneNumController.text,
                                    password: passwordController.text,
                                    passwordConfirm:
                                        passwordConfirmController.text,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'احراز هویت',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'irs',
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              listener: (context, state) {
                if (state is SignUpCompletedState) {
                  SecureStorage().saveUserToken(state.token);
                  getSnackBarWidget(
                    context,
                    'شماره موبایل تایید شد',
                    Colors.green,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneAuthScreen(
                        phoneNumber: phoneNumController.text,
                      ),
                    ),
                  );
                }
                if (state is SignUpErrorState) {
                  getSnackBarWidget(
                    context,
                    state.errorMessageClass.errorMsg!,
                    Colors.red,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
