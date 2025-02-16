import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:real_state/const/shape/border_radius.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/home_features/logic/bloc/home_bloc.dart';
import 'package:real_state/features/home_features/services/home_api_repository.dart';
import 'package:real_state/features/public_features/functions/lorem/lorem.dart';
import 'package:real_state/features/public_features/widget/error_screen_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../state_features/screen/state_info_screen.dart';
import '../model/home_model.dart';
import '../widget/home_content_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String screenId = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        HomeApiRepository(),
      )..add(CallHomeEvent()),
      child: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
        },
        child: Scaffold(
          backgroundColor: primary2Color,
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return Center(
                  child: CircularProgressIndicator(color: primaryColor,),
                );
              }
              if (state is HomeCompletedState) {
                return HomeContent(homeModel: state.homeModel);
              }
              if (state is HomeErrorState) {
                return ErrorScreenWidget(
                  errorMsg: state.error.errorMsg!,
                  function: () {
                    BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
                  },
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
