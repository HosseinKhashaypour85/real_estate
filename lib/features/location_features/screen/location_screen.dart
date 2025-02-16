import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LiveLocationScreen extends StatefulWidget {
  const LiveLocationScreen({Key? key}) : super(key: key);

  @override
  _LiveLocationScreenState createState() => _LiveLocationScreenState();
}

class _LiveLocationScreenState extends State<LiveLocationScreen> {
  Position? _currentPosition;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  Future<void> _startLocationUpdates() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = "سرویس مکان‌یاب غیرفعال است.";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = "دسترسی به موقعیت مکانی رد شد.";
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage =
          "مجوز دسترسی برای همیشه رد شده است. لطفاً از تنظیمات آن را فعال کنید.";
        });
        return;
      }

      // دریافت موقعیت مکانی زنده
      Geolocator.getPositionStream().listen((Position position) {
        setState(() {
          _currentPosition = position;
          _errorMessage = null;
        });
      });
    } catch (e) {
      setState(() {
        _errorMessage = "خطا در دریافت موقعیت مکانی: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('موقعیت مکانی زنده'),
      ),
      body: Center(
        child: _errorMessage != null
            ? Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        )
            : _currentPosition == null
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'عرض جغرافیایی: ${_currentPosition!.latitude}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'طول جغرافیایی: ${_currentPosition!.longitude}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
