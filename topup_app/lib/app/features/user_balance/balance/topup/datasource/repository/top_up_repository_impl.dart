import 'dart:io';
import 'package:base_common/app/network/base_data_state.dart';
import 'package:dio/dio.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/datasource/remote/top_up_service.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/entity/top_up_entity.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/repository/top_up_repository.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';

class TopUpRepositoryImpl implements TopUpRepository {
  TopUpRepositoryImpl(this._getUserService);

  final TopUpService _getUserService;

  @override
  Future<DataState<UserModel?>> topUp(TopUpEntity? topUpEntity) async {
    final Response<UserModel> response =
        await _getUserService.topUp(topUpEntity);
    if (response.statusCode == HttpStatus.ok) {
      return SuccessDataState<UserModel?>(response.data);
    }
    return ErrorDataState<UserModel>(
        DioException(requestOptions: response.requestOptions));
  }
}
