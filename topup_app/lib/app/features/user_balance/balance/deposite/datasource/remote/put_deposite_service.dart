import 'dart:convert';

import 'package:base_common/globals.dart';
import 'package:dio/dio.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';

class PutDepositeService {
  PutDepositeService();

  Future<Response<UserModel>> deposite(double amount) async {
    try {
      final String input = userJson;
      final UserModel map = UserModel.fromJson(jsonDecode(input));
      final double newBalance = (map.balance ?? 0.0) + amount;
      final UserModel updatedUser = UserModel(
        map.name,
        map.phone,
        newBalance,
        map.currency,
        map.fees,
        map.isVerified,
        map.beneficiaries,
        map.availableTopUp,
        map.history,
        map.monthlyTransfer,
        map.monthlyTransferPerUser,
      );
      updateUser(jsonEncode(updatedUser.toJson()));

      return Response<UserModel>(
        statusCode: 200,
        data: updatedUser,
        requestOptions: RequestOptions(),
      );
    } on DioException catch (ex) {
      return Response<UserModel>(
        statusMessage: ex.response.toString(),
        requestOptions: RequestOptions(),
      );
    }
  }
}
