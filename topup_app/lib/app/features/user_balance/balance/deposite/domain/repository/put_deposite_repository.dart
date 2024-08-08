import 'package:base_common/app/network/base_data_state.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/model/user_model.dart';

abstract class PutDepositeRepository {
  Future<DataState<UserModel?>> deposite(double amount);
}
