import 'package:base_common/app/network/base_data_state.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/entity/top_up_entity.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';

abstract class TopUpRepository {
  Future<DataState<UserModel?>> topUp(TopUpEntity? user);
}
