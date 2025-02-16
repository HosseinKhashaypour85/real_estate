import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/features/public_features/logic/pref/save_phone_number.dart';
import 'package:real_state/features/public_features/widget/snack_bar_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/lorem/lorem.dart';
import '../../state_features/screen/state_info_screen.dart';
import '../model/home_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.homeModel});

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary2Color,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'خانه‌ها',
          style: TextStyle(
            fontFamily: 'irs',
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final phoneNumber = await getPhoneNumber();
              if(phoneNumber != null){
                getSnackBarWidget(context, phoneNumber, Colors.green);
              } else{
                getSnackBarWidget(context, 'ابتدا وارد حساب کاربری شوید', Colors.red);
              }
            },
            icon: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeModel.items!.length,
          itemBuilder: (context, index) {
            final helper = homeModel.items![index];
            return Container(
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: getBorderRadiusFunc(10),
              ),
              padding: EdgeInsets.all(10.sp),
              margin: EdgeInsets.all(10.sp),
              width: getAllWidth(context),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: getBorderRadiusFunc(10),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/images/logo2.png'),
                      image: NetworkImage(helper.imageUrl!),
                      width: getWidth(context, 0.5),
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) => Container(),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    helper.title!,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'irs',
                      fontSize: 16.sp,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StateInfoScreen(),
                              settings: RouteSettings(
                                arguments: {
                                  'id': helper.id!,
                                  'imageUrl': helper.imageUrl!,
                                  'desc': Lorem().LoremAdress,
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'مشاهده ملک',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'sahel',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          final url = 'tel:+989120776658';
                          if (await canLaunchUrlString(url)) {
                            launchUrlString(url);
                          }
                        },
                        child: Text(
                          'ارتباط با صاحب ملک',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'irs',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  ExpandableText(
                    Lorem().LoremAdress,
                    expandText: 'بیشتر',
                    collapseText: 'کمتر',
                    maxLines: 2,
                    linkColor: primaryColor,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'irs',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
