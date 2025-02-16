import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: getBorderRadiusFunc(10),
      ),
      child: ListTile(
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'sahel',
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}