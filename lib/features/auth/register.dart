import 'package:cosmetics/core/network/api_constant.dart';
import 'package:cosmetics/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//model
class RegisterRequestModel {
  final String username;
  final String countryCode;
  final String phoneNumber;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.username,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
    };
  }
}

class RegisterResponseModel {
  final String message;

  RegisterResponseModel({required this.message});

 static RegisterResponseModel fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(message: json["message"]);
  }
}

//ui send data -> cubit take data and emit state -> dio send request -> response = massage only
//state
class RegisterState {
  final bool isInitial;
  final bool isLoading;
  final RegisterResponseModel? registerResponseModel;
  final String? errorMessage;

  RegisterState({
    required this.isLoading,
    this.errorMessage,
    required this.isInitial,
    this.registerResponseModel,
  });
}

//cubit
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState(isLoading: false, isInitial: true));

  Future<void> register(RegisterRequestModel registerRequestModel) async {
    emit(RegisterState(isLoading: true, isInitial: false));
    final dio = DioClient.getDio();
    try {

      final response = await dio?.post(
        ApiConstant.register,
        data: registerRequestModel.toJson(),
      );
      print("##################hi from try ${response?.data}");
      if (response == null || response.data == null ||response.statusCode == 200) {
        emit(RegisterState(
          isLoading: false,
          isInitial: false,
          registerResponseModel: RegisterResponseModel.fromJson(response?.data),
        ));
      }else{
        emit(RegisterState(isLoading: false, isInitial: false,errorMessage: response.data["message"]));
      }

    } on DioException catch (e) {
      print("hi form catch error ${e.toString()}");
      emit(RegisterState(isLoading: false, isInitial: false,errorMessage: e.toString()));
    }
  }
}
