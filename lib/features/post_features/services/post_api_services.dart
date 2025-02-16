import 'dart:io';
import 'package:dio/dio.dart';

class PostApiServices {
  final Dio _dio = Dio();

  Future<Response> callPostApi(String title, File imageFile) async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/real_state/records';

    try {
      // ساخت داده فرم برای ارسال فایل و اطلاعات
      final formData = FormData.fromMap({
        'title': title,
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last, // استخراج نام فایل
        ),
      });

      // ارسال درخواست POST
      final Response response = await _dio.post(
        apiUrl,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
        }),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
