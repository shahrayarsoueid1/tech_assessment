import 'package:base_common/app/network/base_data_state.dart';
import 'package:base_common/app/network/base_use_case.dart';
import 'package:topup_app/app/features/beneficiaries/domain/entity/beneficiaries_entity.dart';
import 'package:topup_app/app/features/beneficiaries/domain/repository/get_beneficiaries_repository.dart';

abstract class GetBeneficiariesUsecase
    implements BaseUseCase<BeneficiariesEntity?, void> {}

class GetBeneficiariesUsecaseImpl implements GetBeneficiariesUsecase {
  GetBeneficiariesUsecaseImpl(this._repository);

  final GetBeneficiariesRepository _repository;

  @override
  Future<DataState<BeneficiariesEntity?>> call({void params}) {
    return _repository.getBeneficiaries();
  }
}
