import 'dart:io';
import 'package:base_common/app/network/base_data_state.dart';
import 'package:dio/dio.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/datasource/remote/put_deposite_service.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/domain/repository/put_deposite_repository.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';

class PutDepositeRepositoryImpl implements PutDepositeRepository {
  PutDepositeRepositoryImpl(this._putDepositeRepository);

  final PutDepositeService _putDepositeRepository;

  @override
  Future<DataState<UserModel?>> deposite(double amount) async {
    final Response<UserModel> response =
        await _putDepositeRepository.deposite(amount);
    if (response.statusCode == HttpStatus.ok) {
      return SuccessDataState<UserModel?>(response.data);
    }
    return ErrorDataState<UserModel>(
        DioException(requestOptions: response.requestOptions));
  }
}
