import 'package:cosmetics/core/logic/cash_helper.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

   String baseUrl="http://www.cosmatics.growfet.com/";
   Duration apiTimeOut= const Duration(seconds: 30);
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

enum DataStates {
  uninitialized,
  loading,
  loaded,
  error,
}

class CustomResponse{
  final bool isSuccess;
  final dynamic data;
  final String? msg;
  CustomResponse({required this.isSuccess, required this.data, this.msg});
}

class DioHelper {
 static final Dio _dio = Dio()
      ..options.baseUrl = baseUrl
       ..options.headers = {"Accept":"application/json","Content-Type":"application/json"}
      ..options.validateStatus = (status) {
        return status != null && status < 500;
      }
      ..options.connectTimeout = apiTimeOut
      ..options.receiveTimeout = apiTimeOut
      ..options.sendTimeout = apiTimeOut
      ..interceptors.add(PrettyDioLogger(request: true, requestBody: true, responseBody: true, error: true),);

 static  Future<CustomResponse> postData({required String endpoint,required dynamic data}) async {
   if(endpoint=="api/Auth/logout") {
     var token = CashHelper.getToken();
     _dio.options.headers.addAll({"Authorization": "Bearer $token"});
   }
    try {
      final response = await _dio.post<dynamic>(endpoint, data: data,);
      if (response.data == null || response.statusCode == 200) {
        return CustomResponse(isSuccess: true,data: response.data);
      }
      return CustomResponse(isSuccess: false,data: response.data);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false,data: ex.response?.data);
    }
  }
  static  Future<CustomResponse> putData({required String endpoint,required dynamic data}) async {
    var token = CashHelper.getToken();
    _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    try {
      final response = await _dio.put<dynamic>(endpoint, data: data);
      if (response.data == null || response.statusCode == 200) {
        return CustomResponse(isSuccess: true,data: response.data);
      }
      return CustomResponse(isSuccess: false,data: response.data);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false,data: ex.response?.data);
    }
  }
  static  Future<CustomResponse> getData(String endpoint,[dynamic queryParameters]) async {
   if(endpoint=="api/Auth/profile") {
     var token =CashHelper.getToken();
     _dio.options.headers.addAll({"Authorization": "Bearer $token"});
   }
    try {
      final response = await _dio.get<dynamic>(endpoint, queryParameters: queryParameters,);
      if (response.data == null || response.statusCode == 200) {
        return CustomResponse(isSuccess: true,data: response.data);
      }
      return CustomResponse(isSuccess: false,data: response.data);
    } on DioException catch (ex) {
      return CustomResponse(isSuccess: false,msg: ex.message, data: {});
    }
  }
}
