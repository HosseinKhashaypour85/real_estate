import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/shape/border_radius.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/profile_features/widget/aboutUs_widget.dart';
import 'package:real_state/features/profile_features/widget/log_out_widget.dart';
import 'package:real_state/features/public_features/functions/secure_storage/secure_storage.dart';
import 'package:real_state/features/public_features/logic/pref/save_phone_number.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String screenId = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _loadNumber();
  }

  void _loadNumber() async {
    String? getNumber = await getPhoneNumber();
    setState(() {
      phoneNumber = getNumber ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary2Color,
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 10.sp,
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: getAllWidth(context),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: getBorderRadiusFunc(5),
                ),
                padding: EdgeInsets.all(10.sp),
                margin: EdgeInsets.all(10.sp),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: getWidth(context, 0.08),
                      backgroundColor: iconColor,
                      child: Icon(
                        Icons.person,
                        size: 28.sp,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      'کاربر گرامی $phoneNumber',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'irs',
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
              AboutUsWidget(
                title: 'درباره ما',
                onTap: () async {
                  final url = 'https://hosseinkhashaypour.ir/';
                  if (await canLaunchUrlString(url)) {
                    launchUrlString(url);
                  }
                },
              ),
              AboutUsWidget(
                title: 'ارتباط با ما',
                onTap: () async {
                  final url = 'tel:+989120776658';
                  if (await canLaunchUrlString(url)) {
                    launchUrlString(url);
                  }
                },
              ),
              Spacer(),
              Column(
                children: [
                  LogOutWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
