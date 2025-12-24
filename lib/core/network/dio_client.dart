import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constant.dart';

class DioClient {

  DioClient._();
  static Dio? dio;

 static Dio getDio(){
    dio ??= Dio(BaseOptions(
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ))
     ..options.baseUrl = ApiConstant.baseUrl
     ..options.connectTimeout = ApiConstant.apiTimeOut
     ..options.receiveTimeout = ApiConstant.apiTimeOut
     ..options.sendTimeout = ApiConstant.apiTimeOut
      ..interceptors.add(
       PrettyDioLogger(
       request: true,
       requestBody: true,
       responseBody: true,
       error: true,
     ));

    return dio!;
  }
}