import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/features/auth_features/logic/auth_bloc.dart';
import 'package:real_state/features/auth_features/services/auth_api_repository.dart';
import 'package:real_state/features/home_features/logic/bloc/home_bloc.dart';
import 'package:real_state/features/home_features/services/home_api_repository.dart';
import 'package:real_state/features/intro_features/logic/intro_cubit.dart';
import 'package:real_state/features/intro_features/screen/splash_screen.dart';
import 'package:real_state/features/post_features/logic/post_bloc.dart';
import 'package:real_state/features/post_features/services/post_api_repository.dart';
import 'package:real_state/features/public_features/logic/token_checker/token_check_cubit.dart';

import 'features/auth_features/screen/auth_screen.dart';
import 'features/auth_features/screen/check_customer_type_screen.dart';
import 'features/auth_features/screen/sign_up_screen.dart';
import 'features/home_features/screen/home_screen.dart';
import 'features/intro_features/screen/intro_screen.dart';
import 'features/profile_features/screens/profile_check.dart';
import 'features/profile_features/screens/profile_screen.dart';
import 'features/public_features/screen/bottom_nav_screen.dart';
import 'features/state_features/screen/payment_webview.dart';
import 'features/state_features/screen/state_info_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => IntroCubit(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(
              HomeApiRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => TokenCheckCubit(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              AuthApiRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => PostBloc(
              PostApiRepository(),
            ),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('fa'),
          ],
          initialRoute: SplashScreen.screenId,
          routes: {
            SplashScreen.screenId: (context) => SplashScreen(),
            BottomNavScreen.screenId: (context) => BottomNavScreen(),
            IntroScreen.screenId: (context) => IntroScreen(),
            HomeScreen.screenId: (context) => HomeScreen(),
            StateInfoScreen.screenId: (context) => StateInfoScreen(),
            ProfileCheck.screenId: (context) => ProfileCheck(),
            ProfileScreen.screenId: (context) => ProfileScreen(),
            AuthScreen.screenId: (context) => AuthScreen(),
            checkCustomerTypeScreen.screenId: (context) =>
                checkCustomerTypeScreen(),
            SignUpScreen.screenId: (context) => SignUpScreen(),
            PaymentSWebViewScreen.screenId: (context) => PaymentSWebViewScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
