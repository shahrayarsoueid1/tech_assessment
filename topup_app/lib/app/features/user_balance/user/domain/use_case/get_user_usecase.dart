import 'package:base_common/app/network/base_data_state.dart';
import 'package:base_common/app/network/base_use_case.dart';
import 'package:topup_app/app/features/user_balance/user/domain/entity/user_entity.dart';
import 'package:topup_app/app/features/user_balance/user/domain/repository/user_repository.dart';

abstract class GetUserUsecase implements BaseUseCase<UserEntity?, void> {}

class GetUserUsecaseImpl implements GetUserUsecase {
  GetUserUsecaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<DataState<UserEntity?>> call({void params}) {
    return _repository.getUser();
  }
}
