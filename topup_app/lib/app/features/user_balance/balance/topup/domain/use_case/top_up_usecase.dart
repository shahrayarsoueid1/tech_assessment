import 'package:base_common/app/network/base_data_state.dart';
import 'package:base_common/app/network/base_use_case.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/entity/top_up_entity.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/repository/top_up_repository.dart';
import 'package:topup_app/app/features/user_balance/user/domain/entity/user_entity.dart';

abstract class TopUpUsecase implements BaseUseCase<UserEntity?, TopUpEntity?> {}

class TopUpUsecaseImpl implements TopUpUsecase {
  TopUpUsecaseImpl(this._repository);

  final TopUpRepository _repository;

  @override
  Future<DataState<UserEntity?>> call({TopUpEntity? params}) {
    return _repository.topUp(params);
  }
}
