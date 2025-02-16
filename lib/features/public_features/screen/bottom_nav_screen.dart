import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/home_features/logic/bloc/home_bloc.dart';
import 'package:real_state/features/home_features/services/home_api_repository.dart';
import 'package:real_state/features/home_features/screen/home_screen.dart';
import 'package:real_state/features/post_features/screens/check_post.dart';
import 'package:real_state/features/profile_features/screens/profile_check.dart';

import '../../location_features/screen/location_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  static const String screenId = '/bottomnav'; // مسیر صفحه

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  // کلیدهای یکتا برای هر Navigator
  final GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> locationKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> addPostKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();

  // تعریف صفحات مرتبط با تب‌ها
  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) => HomeBloc(HomeApiRepository())
          ..add(CallHomeEvent()), // رویداد اولیه برای رفرش
        child: Navigator(
          key: homeKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => WillPopScope(
              onWillPop: () async {
                BlocProvider.of<HomeBloc>(homeKey.currentContext!)
                    .add(CallHomeEvent()); // رفرش هنگام بازگشت
                return true;
              },
              child: HomeScreen(),
            ),
          ),
        ),
      ),
      Navigator(
        key: locationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => LiveLocationScreen(),
        ),
      ),
      Navigator(
        key: addPostKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => CheckPost(),
        ),
      ),
      Navigator(
        key: profileKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => ProfileCheck(),
        ),
      ),
    ];
  }

  // تعریف آیتم‌های نوار پایین
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "خانه",
        activeColorPrimary: primaryColor,
        textStyle: TextStyle(fontFamily: 'irs'),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.location_on),
        title: "لوکیشن",
        textStyle: TextStyle(fontFamily: 'irs'),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: "افزودن پست",
        textStyle: TextStyle(fontFamily: 'irs'),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "پروفایل",
        textStyle: TextStyle(fontFamily: 'irs'),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.grey.shade900,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style1,
      onItemSelected: (index) {
        if (index == 0) {
          // رفرش صفحه "خانه" هنگام انتخاب
          homeKey.currentState?.popUntil((route) => route.isFirst);
          BlocProvider.of<HomeBloc>(homeKey.currentContext!)
              .add(CallHomeEvent());
        }
      },
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
    );
  }
}
