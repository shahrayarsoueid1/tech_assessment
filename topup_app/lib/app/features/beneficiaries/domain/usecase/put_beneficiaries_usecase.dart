import 'package:base_common/app/network/base_data_state.dart';
import 'package:base_common/app/network/base_use_case.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';
import 'package:topup_app/app/features/beneficiaries/domain/entity/beneficiaries_entity.dart';
import 'package:topup_app/app/features/beneficiaries/domain/repository/put_beneficiary_repository.dart';

abstract class PutBeneficiariesUsecase
    implements BaseUseCase<BeneficiariesEntity?, BeneficiaryModel?> {}

class PutBeneficiariesUsecaseImpl implements PutBeneficiariesUsecase {
  PutBeneficiariesUsecaseImpl(this._repository);

  final PutBeneficiaryRepository _repository;

  @override
  Future<DataState<BeneficiariesEntity?>> call({BeneficiaryModel? params}) {
    return _repository.putBeneficiary(params);
  }
}
