import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../public_features/screen/bottom_nav_screen.dart';
import '../../public_features/widget/snack_bar_widget.dart';

class PaymentSWebViewScreen extends StatefulWidget {
  const PaymentSWebViewScreen({super.key});

  static const String screenId = '/payment_webview_screen';

  @override
  State<PaymentSWebViewScreen> createState() => _PaymentSWebViewScreenState();
}

class _PaymentSWebViewScreenState extends State<PaymentSWebViewScreen> {
  late final WebViewController _controller;
  int pressCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
  }

  /// مقداردهی WebViewController
  void _initializeWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url == 'app://prokala/succeed') {
              // موفقیت در پرداخت
              _handlePaymentSuccess();
              return NavigationDecision.prevent;
            } else if (request.url == 'app://prokala/failed') {
              // شکست در پرداخت
              _handlePaymentFailure();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://programmingshow.ir/programminshow/deeplink.html'),
      );
  }

  /// مدیریت موفقیت پرداخت
  void _handlePaymentSuccess() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('پرداخت شما با موفقیت ثبت شد'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        BottomNavScreen.screenId,
            (route) => false,
      );
    }
  }

  /// مدیریت شکست پرداخت
  void _handlePaymentFailure() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('پرداخت شما با شکست مواجه شد، دوباره تلاش کنید'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        BottomNavScreen.screenId,
            (route) => false,
      );
    }
  }

  /// مدیریت دکمه بازگشت دستگاه
  Future<bool> _handleWillPop() async {
    final canGoBack = await _controller.canGoBack();
    if (canGoBack) {
      _controller.goBack();
      return false; // اجازه خروج از صفحه را نمی‌دهد
    } else {
      pressCount++;
      if (pressCount == 2) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          BottomNavScreen.screenId,
              (route) => false,
        );
        return true; // خروج از صفحه
      } else {
        Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() => pressCount--);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('برای بازگشت به صفحه اصلی یکبار دیگر کلیک کنید'),
              backgroundColor: Colors.black,
            ),
          );
        }
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: SafeArea(
        child: Scaffold(
          body: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}
