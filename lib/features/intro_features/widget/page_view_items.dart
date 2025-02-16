import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';

class PageViewItems extends StatelessWidget {
  const PageViewItems({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  final String image;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        spacing: 5.sp,
        children: [
          Image.asset(
            image,
            width: getWidth(context, 0.2),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'sahel',
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
          Text(
            desc,
            style: TextStyle(
              fontFamily: 'sahel',
              fontSize: 14.sp,
              color: Colors.white,
            ),
            // overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
