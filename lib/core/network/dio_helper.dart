import 'package:cosmetics/core/logic/cash_helper.dart';
import 'package:cosmetics/core/logic/helper_method.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../views/login.dart';

String baseUrl = "http://www.cosmatics.growfet.com/";
Duration apiTimeOut = const Duration(seconds: 30);
//-----------------------------------------------------------
//Auth
//    String register="api/Auth/register";
//    String verifyOtp="api/Auth/verify-otp";
//    String login="api/Auth/login";
//    String forgotPassword="api/Auth/forgot-password";
//    String resetPassword="api/Auth/reset-password";
//    String profile="api/Auth/profile";
//    String logout="api/Auth/logout";
//-----------------------------------------------------------
//Categories
//Countries
//Products
//Cart
//Orders
//Website Content
//-----------------------------------------------------------

enum DataStates { uninitialized, loading, loaded, error }

class CustomResponse {
  final bool isSuccess;
  final dynamic data;
  final String? msg;

  CustomResponse({required this.isSuccess, required this.data, this.msg});
}

class DioHelper {
  static final Dio _dio = Dio()
    ..options.baseUrl = baseUrl
    ..options.headers = {"Accept": "application/json", "Content-Type": "application/json"}
    ..options.validateStatus = (status) {
      return status != null && status < 500;
    }
    ..options.connectTimeout = apiTimeOut
    ..options.receiveTimeout = apiTimeOut
    ..options.sendTimeout = apiTimeOut
    ..interceptors.addAll({
      PrettyDioLogger(request: true, requestBody: true, responseBody: true, error: true),
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            CashHelper.removeUserDate();
            goto(const LoginView(), canPop: false);
          }
        },
      ),
    });

  static Future<CustomResponse> postData({
    required String endpoint,
     dynamic data,
    dynamic queryParameters,
  }) async {
    var token = CashHelper.getToken();
    _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    try {
      final response = await _dio.post<dynamic>(endpoint, queryParameters: queryParameters, data: data);
      if (response.data == null || response.statusCode == 200) {
        return CustomResponse(isSuccess: true, data: response.data);
      }
      return CustomResponse(isSuccess: false, data: response.data);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false, data: ex.response?.data);
    }
  }

  static Future<CustomResponse> putData({required String endpoint, required dynamic data}) async {
    var token = CashHelper.getToken();
    _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    try {
      final response = await _dio.put<dynamic>(endpoint, data: data);
      if (response.data == null || response.statusCode == 200) {
        return CustomResponse(isSuccess: true, data: response.data);
      }
      return CustomResponse(isSuccess: false, data: response.data);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false, data: ex.response?.data);
    }
  }

  static Future<CustomResponse> getData(String endpoint, [dynamic queryParameters]) async {
    var token = CashHelper.getToken();
    _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    try {
      final response = await _dio.get<dynamic>(endpoint, queryParameters: queryParameters);
      if (response.data == null || response.statusCode == 200) {
        return CustomResponse(isSuccess: true, data: response.data);
      }
      print(response.requestOptions.headers.toString());
      print(response.data);

      return CustomResponse(isSuccess: false, data: response.data);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false, msg: ex.message, data: {});
    }
  }
}
