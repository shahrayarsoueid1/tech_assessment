import 'dart:io';
import 'package:base_common/app/network/base_data_state.dart';
import 'package:dio/dio.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/remote/get_user_service.dart';
import 'package:topup_app/app/features/user_balance/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._getUserService);

  final GetUserService _getUserService;

  @override
  Future<DataState<UserModel?>> getUser() async {
    final Response<UserModel> response = await _getUserService.getUser();
    if (response.statusCode == HttpStatus.ok) {
      return SuccessDataState<UserModel?>(response.data);
    }
    return ErrorDataState<UserModel>(
        DioException(requestOptions: response.requestOptions));
  }
}
