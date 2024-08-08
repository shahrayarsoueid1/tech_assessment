import 'dart:convert';

import 'package:base_common/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';

class GetUserService {
  GetUserService();

  Future<Response<UserModel>> getUser() async {
    try {
      final String input = await rootBundle
          .loadString('packages/topup_app/assets/get_user.json');
      final UserModel map = UserModel.fromJson(jsonDecode(input));
      updateUser(input);
      return Response<UserModel>(
        statusCode: 200,
        data: map,
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
