import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constant.dart';

class DioHelper {
  final Dio _dio = Dio()
      ..options.baseUrl = ApiConstant.baseUrl
      ..options.validateStatus = (status) {
        return status != null && status < 500;
      }
      ..options.connectTimeout = ApiConstant.apiTimeOut
      ..options.receiveTimeout = ApiConstant.apiTimeOut
      ..options.sendTimeout = ApiConstant.apiTimeOut
      ..interceptors.add(PrettyDioLogger(request: true, requestBody: true, responseBody: true, error: true));

   Future<dynamic> postData({required String endpoint,required dynamic data}) async {
    try {
      final response = await _dio.post<dynamic>(endpoint, data: data);
      if (response.data == null || response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      return e.response;
    } catch (e) {
      return e;
    }
  }
}
