import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/post_features/screens/add_post_screen.dart';
import 'package:real_state/features/public_features/logic/token_checker/token_check_cubit.dart';
import 'package:real_state/features/public_features/widget/sign_in_error_widget.dart';

class CheckPost extends StatefulWidget {
  const CheckPost({super.key});

  static const String screenId = '/checkPost';

  @override
  State<CheckPost> createState() => _CheckPostState();
}

class _CheckPostState extends State<CheckPost> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TokenCheckCubit()..tokenChecker(),
      child: BlocBuilder<TokenCheckCubit , TokenCheckState>(
        builder: (context, state) {
          if(state is TokenCheckIsLogedState){
            return AddPostScreen();
          }
          else{
            return SignInErrorWidget();
          }
        },
      ),
    );
  }
}
