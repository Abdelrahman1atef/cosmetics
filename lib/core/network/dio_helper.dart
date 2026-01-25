import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

   String baseUrl="http://www.cosmatics.growfet.com/";
   Duration apiTimeOut= const Duration(milliseconds: 5000);
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
//Categoreis
//Countries
//Products
//Cart
//Orders
//Website Content
//-----------------------------------------------------------
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
      ..interceptors.add(PrettyDioLogger(request: true, requestBody: true, responseBody: true, error: true));

 static  Future<CustomResponse> postData({required String endpoint,required dynamic data}) async {
   if(endpoint=="api/Auth/logout") {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var token = prefs.getString("token");
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
}

class CustomResponse{
  final bool isSuccess;
  final Map<String,dynamic> data;
  CustomResponse({required this.isSuccess, required this.data});
}
