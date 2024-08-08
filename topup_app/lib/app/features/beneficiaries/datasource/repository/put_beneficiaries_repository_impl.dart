import 'dart:io';

import 'package:base_common/app/network/base_data_state.dart';
import 'package:dio/dio.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiaries_model.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/remote/get_beneficiaries_service.dart';
import 'package:topup_app/app/features/beneficiaries/domain/repository/put_beneficiary_repository.dart';

class PutBeneficiaryRepositoryImpl implements PutBeneficiaryRepository {
  PutBeneficiaryRepositoryImpl(this._beneficiariesService);

  final BeneficiariesService _beneficiariesService;

  @override
  Future<DataState<BeneficiariesModel?>> putBeneficiary(
      BeneficiaryModel? beneficiaryModel) async {
    final Response<BeneficiariesModel> response =
        await _beneficiariesService.putBeneficiary(beneficiaryModel);
    if (response.statusCode == HttpStatus.ok) {
      return SuccessDataState<BeneficiariesModel?>(response.data);
    }
    return ErrorDataState<BeneficiariesModel>(
        DioException(requestOptions: response.requestOptions));
  }
}
