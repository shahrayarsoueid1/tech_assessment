import 'dart:convert';

import 'package:base_common/globals.dart';
import 'package:dio/dio.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiaries_model.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';

const int _MAX_BENEFICIARY = 5;

class BeneficiariesService {
  BeneficiariesService();

  Future<Response<BeneficiariesModel>> getBeneficiaries() async {
    try {
      final String input = userJson;

      if (input.isEmpty) {
        return Response<BeneficiariesModel>(
          statusCode: 204,
          data: const BeneficiariesModel(),
          requestOptions: RequestOptions(),
        );
      }

      final UserModel userModel = UserModel.fromJson(jsonDecode(input));

      final BeneficiariesModel beneficiariesResponse = BeneficiariesModel(
        beneficiaries: userModel.beneficiaries,
        isMaxBeneficiaryReached:
            userModel.beneficiaries?.length == _MAX_BENEFICIARY,
      );

      //   final List<TopUpModel> history = userModel.history;

      // double topUpAmountPerUser = 0.0;
      // double topUpFullAnmount = 0.0;

      // for (final TopUpModel item in history) {
      //   if (item.name == topUpEntity?.name &&
      //       item.phone == topUpEntity?.phone) {
      //     topUpAmountPerUser =
      //         topUpAmountPerUser + double.parse(map.balance ?? '0.0');
      //   }
      //   topUpFullAnmount =
      //       topUpFullAnmount + double.parse(topUpEntity?.balance ?? '0.0');
      // }

      return Response<BeneficiariesModel>(
        statusCode: 200,
        data: beneficiariesResponse,
        requestOptions: RequestOptions(),
      );
    } on DioException catch (ex) {
      return Response<BeneficiariesModel>(
        statusMessage: ex.response.toString(),
        requestOptions: RequestOptions(),
      );
    }
  }

  Future<Response<BeneficiariesModel>> putBeneficiary(
    BeneficiaryModel? beneficiaryModel,
  ) async {
    try {
      final String input = userJson;
      final UserModel userModel = UserModel.fromJson(jsonDecode(input));

      final bool beneficiaryExists = userModel.beneficiaries?.any(
              (BeneficiaryModel item) =>
                  item.phone == beneficiaryModel?.phone) ??
          false;
      if (!beneficiaryExists) {
        userModel.beneficiaries?.add(beneficiaryModel!);
      }

      final UserModel updatedUser = UserModel(
        userModel.name,
        userModel.phone,
        userModel.balance,
        userModel.currency,
        userModel.fees,
        userModel.isVerified,
        userModel.beneficiaries,
        userModel.availableTopUp,
        userModel.history,
        userModel.monthlyTransfer,
        userModel.monthlyTransferPerUser,
      );

      updateUser(jsonEncode(updatedUser.toJson()));
      final BeneficiariesModel response = BeneficiariesModel(
        beneficiaries: userModel.beneficiaries,
        isMaxBeneficiaryReached:
            userModel.beneficiaries?.length == _MAX_BENEFICIARY,
      );

      return Response<BeneficiariesModel>(
        statusCode: 200,
        data: response,
        requestOptions: RequestOptions(),
      );
    } on DioException catch (ex) {
      return Response<BeneficiariesModel>(
        statusMessage: ex.response.toString(),
        requestOptions: RequestOptions(),
      );
    }
  }
}
