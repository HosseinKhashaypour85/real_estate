import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/auth_features/logic/auth_bloc.dart';
import 'package:real_state/features/auth_features/services/auth_api_repository.dart';
import 'package:real_state/features/auth_features/widget/auth_section_widget.dart';
import 'package:real_state/features/profile_features/screens/profile_screen.dart';
import 'package:real_state/features/public_features/functions/secure_storage/secure_storage.dart';
import 'package:real_state/features/public_features/screen/bottom_nav_screen.dart';
import 'package:real_state/features/public_features/widget/snack_bar_widget.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../public_features/logic/pref/save_phone_number.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String screenId = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    phoneNumController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        AuthApiRepository(),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is SignInAuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return Scaffold(
            backgroundColor: primary2Color,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AuthScreenContent(),
                        AuthSectionWidget(
                          numberController: phoneNumController,
                          formController: formKey,
                          passwordController: passwordController,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is SignInAuthErrorState) {
            getSnackBarWidget(
                context, state.errorMessageClass.errorMsg!, Colors.red);
          }
          if (state is SignInAuthCompletedState) {
            SecureStorage().saveUserToken(state.token);
            savePhoneNumber(phoneNumController.text);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}

class AuthScreenContent extends StatelessWidget {
  const AuthScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context, 0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: getBorderRadiusFunc(100),
              child: FadeInUp(
                child: Image.asset(
                  'assets/images/logo2.png',
                  width: getWidth(context, 0.5),
                ),
              ),
            ),
            Text(
              'www.codeplus.ir',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'sahel',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
