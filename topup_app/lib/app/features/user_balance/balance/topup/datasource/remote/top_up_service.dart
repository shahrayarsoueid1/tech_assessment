import 'dart:convert';

import 'package:base_common/globals.dart';
import 'package:dio/dio.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/datasource/model/top_up_model.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/entity/top_up_entity.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/utils/top_up_utils.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';

const int MAX_AMOUNT_PER_VERIFIED_USER = 1000;
const int MAX_AMOUNT_PER_UN_VERIFIED_USER = 500;
const int MAX_AMOUNT_PER_MONTH = 3000;

class TopUpService {
  TopUpService();

  Future<Response<UserModel>> topUp(TopUpEntity? topUpEntity) async {
    try {
      final String input = userJson;

      final UserModel map = UserModel.fromJson(jsonDecode(input));

      final double fullAmount = getFullAmount(
        topUpEntity?.balance,
        topUpEntity?.fees,
      );
      final double newBalance = (map.balance ?? 0.0) - fullAmount;
      final List<TopUpModel> history = map.history;
      final TopUpModel topUpModel = TopUpModel(
        topUpEntity?.name,
        topUpEntity?.phone,
        topUpEntity?.balance,
        map.currency,
        topUpEntity?.fees,
      );
      history.add(topUpModel);

      double topUpAmountPerUser = 0.0;
      double topUpFullAnmount = 0.0;

      for (final TopUpModel item in history) {
        if (topUpEntity?.phone == item.phone) {
          topUpAmountPerUser = topUpAmountPerUser + (item.balance ?? 0);
        }
        topUpFullAnmount = topUpFullAnmount + (item.balance ?? 0.0);
      }

      final UserModel updatedUser = UserModel(
        map.name,
        map.phone,
        newBalance,
        map.currency,
        map.fees,
        map.isVerified,
        map.beneficiaries,
        map.availableTopUp,
        history,
        topUpFullAnmount,
        topUpAmountPerUser,
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
