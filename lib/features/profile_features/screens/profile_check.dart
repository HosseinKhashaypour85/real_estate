import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/profile_features/screens/profile_screen.dart';
import 'package:real_state/features/public_features/logic/token_checker/token_check_cubit.dart';

import '../../auth_features/screen/auth_screen.dart';

class ProfileCheck extends StatefulWidget {
  const ProfileCheck({super.key});

  static const String screenId = '/profileCheck';

  @override
  State<ProfileCheck> createState() => _ProfileCheckState();
}

class _ProfileCheckState extends State<ProfileCheck> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TokenCheckCubit()..tokenChecker(),
      child: BlocBuilder<TokenCheckCubit , TokenCheckState>(
        builder: (context, state) {
          if(state is TokenCheckIsLogedState){
            return ProfileScreen();
          } else{
            return AuthScreen();
          }
        },
      ),
    );
  }
}
