import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio = Dio();
  Future<Response<dynamic>> getData({
    required String url, 
    Map<String, dynamic>? query,
  }) async {
    final response = await dio.get(
      url,
      queryParameters: query,
    );
    return response;
  }

  Future<Response<dynamic>> postData({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final response = await dio.post(
      path,
      data: body,
      queryParameters: query,
    );
    return response;
  }
}
