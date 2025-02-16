import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/const/shape/border_radius.dart';
import 'package:real_state/const/shape/media_query.dart';
import 'package:real_state/const/theme/colors.dart';
import 'package:real_state/features/public_features/widget/snack_bar_widget.dart';
import 'package:real_state/features/state_features/screen/payment_webview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StateInfoScreen extends StatefulWidget {
  const StateInfoScreen({super.key});

  static const String screenId = 'stateInfoScreen';

  @override
  State<StateInfoScreen> createState() => _StateInfoScreenState();
}

class _StateInfoScreenState extends State<StateInfoScreen> {
  bool isFavorite = false;

  Future<void> _saveFavStatus(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('favorite_$id', isFavorite);
  }

  Future<void> _loadFavStatus(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = pref.getBool('favorite_$id') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _loadFavStatus(arguments['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String id = arguments['id'];
    return Scaffold(
      backgroundColor: primary2Color,
      body: SafeArea(
        child: Column(
          children: [
            // Header Row with Favorite and Back Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFavoriteButton(id),
                _buildBackButton(context),
              ],
            ),

            // Image Section
            _buildImageSection(arguments['imageUrl'], context),

            // Description Section
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                arguments['desc'],
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'irs',
                ),
              ),
            ),

            Spacer(),

            _buildPurchaseButton(context),

            // Contact Owner Button
            _buildContactOwnerButton(),
          ],
        ),
      ),
    );
  }

  /// Favorite Button Widget
  Widget _buildFavoriteButton(String id) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: getBorderRadiusFunc(10),
        color: iconColor,
      ),
      margin: EdgeInsets.all(10.sp),
      child: IconButton(
        onPressed: () async {
          setState(() {
            isFavorite = !isFavorite; // تغییر وضعیت علاقه‌مندی
          });

          await _saveFavStatus(id); // ذخیره وضعیت علاقه‌مندی

          // نمایش پیام SnackBar
          final message = isFavorite
              ? 'به علاقه‌مندی‌ها اضافه شد'
              : 'از علاقه‌مندی‌ها حذف شد';
          final color = isFavorite ? Colors.green : Colors.red;
          getSnackBarWidget(context, message, color);
        },
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_outlined,
          color: isFavorite ? Colors.red : Colors.grey,
        ),
      ),
    );
  }

  /// Back Button Widget
  Widget _buildBackButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: getBorderRadiusFunc(10),
        color: iconColor,
      ),
      margin: EdgeInsets.all(10.sp),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Image Section Widget
  Widget _buildImageSection(String imageUrl, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: ClipRRect(
        borderRadius: getBorderRadiusFunc(10),
        child: Image.network(
          imageUrl,
          width: getAllWidth(context),
        ),
      ),
    );
  }

  /// Purchase Button Widget
  Widget _buildPurchaseButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          fixedSize: Size(
            getAllWidth(context),
            getHeight(context, 0.05),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: getBorderRadiusFunc(5),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'هشدار !',
                  style: TextStyle(
                    fontFamily: 'irs',
                    fontSize: 16.sp,
                  ),
                ),
                content: Text(
                  'آیا از پرداخت کمیسیون مطمعن هستید؟',
                  style: TextStyle(
                    fontFamily: 'irs',
                    fontSize: 17.sp,
                  ),
                ),
                actions: [
                  Row(
                    spacing: 10.sp,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          fixedSize: Size(
                            getWidth(context, 0.4),
                            getHeight(context, 0.04),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, PaymentSWebViewScreen.screenId);
                        },
                        child: Text(
                          'بله',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'irs',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'خیر',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'irs',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Text(
          'خرید ملک و تنظیم قرار داد',
          style: TextStyle(
            fontFamily: 'irs',
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  /// Contact Owner Button Widget
  Widget _buildContactOwnerButton() {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          fixedSize: Size(
            getAllWidth(context),
            getHeight(context, 0.05),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: getBorderRadiusFunc(5),
          ),
        ),
        onPressed: () async {
          const url = 'tel:+989120776658';
          if (await canLaunchUrlString(url)) {
            launchUrlString(url);
          }
        },
        child: Text(
          'ارتباط با مالک',
          style: TextStyle(
            fontFamily: 'irs',
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
