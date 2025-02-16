import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/features/intro_features/logic/intro_cubit.dart';
import 'package:real_state/features/public_features/functions/pref/shared_pref.dart';
import 'package:real_state/features/public_features/screen/bottom_nav_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../const/theme/colors.dart';
import '../widget/page_view_items.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const String screenId = '/intro';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    List<Widget> pageViewItem = [
      PageViewItems(
        image: 'assets/images/home.png',
        title: 'بهترین فایل ها',
        desc: 'بهترین فایل های عکس هارو از ما بخواهید',
      ),
      PageViewItems(
        image: 'assets/images/fast.png',
        title: 'پیدا کردن در کمترین زمان',
        desc: 'پیدا کردن سریع خانه با قابلیت فیلتر',
      ),
      PageViewItems(
        image: 'assets/images/tax.png',
        title: 'کمترین مالیات',
        desc: 'پرداخت کمترین مالیات به ما',
      ),
    ];
    return Scaffold(
      backgroundColor: primary2Color,
      body: BlocBuilder<IntroCubit, int>(
        builder: (context, state) {
          final introCubit = BlocProvider.of<IntroCubit>(context);
          return Stack(
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: getHeight(context, 0.2),
                  color: primaryColor,
                  child: Center(
                    child: Container(),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: getAllWidth(context),
                      height: getHeight(context, 0.5),
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: pageViewItem.length,
                        itemBuilder: (context, index) {
                          return pageViewItem[index];
                        },
                        onPageChanged: (value) {
                          introCubit.changeIndex(value);
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(getWidth(context, 0.7), 50),
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                        if (introCubit.currentIndex < 2) {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        } else {
                          SharedPref().setIntroStatus();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            BottomNavScreen.screenId,
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        introCubit.currentIndex < 2 ? 'بعدی' : 'بزن بریم',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'irs',
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: pageViewItem.length,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 5,
                        activeDotColor: primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

