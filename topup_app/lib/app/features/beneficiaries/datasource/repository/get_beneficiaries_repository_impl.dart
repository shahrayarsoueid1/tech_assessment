import 'dart:io';

import 'package:base_common/app/network/base_data_state.dart';
import 'package:dio/dio.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiaries_model.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/remote/get_beneficiaries_service.dart';
import 'package:topup_app/app/features/beneficiaries/domain/repository/get_beneficiaries_repository.dart';

class BeneficiariesRepositoryImpl implements GetBeneficiariesRepository {
  BeneficiariesRepositoryImpl(this._beneficiariesService);

  final BeneficiariesService _beneficiariesService;

  @override
  Future<DataState<BeneficiariesModel?>> getBeneficiaries() async {
    final Response<BeneficiariesModel> response =
        await _beneficiariesService.getBeneficiaries();
    if (response.statusCode == HttpStatus.ok) {
      return SuccessDataState<BeneficiariesModel?>(response.data);
    }
    return ErrorDataState<BeneficiariesModel>(
        DioException(requestOptions: response.requestOptions));
  }
}
