import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_constant.dart';
import '../../../core/network/dio_client.dart';
import 'model.dart';

part  'state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState(isLoading: false, isInitial: true));

  Future<void> register(RegisterRequestModel registerRequestModel) async {
    emit(RegisterState(isLoading: true, isInitial: false));
    final dio = DioClient.getDio();
    try {

      final response = await dio.post(
        ApiConstant.register,
        data: registerRequestModel.toJson(),
      );
      if (response.data == null ||response.statusCode == 200) {
        emit(RegisterState(
          isLoading: false,
          isInitial: false,
          registerResponseModel: RegisterResponseModel.fromJson(response.data),
        ));
      }else{
        emit(RegisterState(isLoading: false, isInitial: false,errorMessage: response.data["message"]));
      }

    } on DioException catch (e) {
      emit(RegisterState(isLoading: false, isInitial: false,errorMessage: e.toString()));
    }
  }
}