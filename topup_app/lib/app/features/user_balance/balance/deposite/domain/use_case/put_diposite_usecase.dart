import 'package:base_common/app/network/base_data_state.dart';
import 'package:base_common/app/network/base_use_case.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/domain/repository/put_deposite_repository.dart';
import 'package:topup_app/app/features/user_balance/user/domain/entity/user_entity.dart';

abstract class PutDipositeUsecase implements BaseUseCase<UserEntity?, double> {}

class PutDipositeUsecaseImpl implements PutDipositeUsecase {
  PutDipositeUsecaseImpl(this._repository);

  final PutDepositeRepository _repository;

  @override
  Future<DataState<UserEntity?>> call({double? params}) {
    return _repository.deposite(params ?? 0.0);
  }
}
