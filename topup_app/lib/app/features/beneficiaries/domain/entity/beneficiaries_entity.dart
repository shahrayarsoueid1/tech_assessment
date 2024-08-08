import 'package:equatable/equatable.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';

class BeneficiariesEntity extends Equatable {
  const BeneficiariesEntity(
    this.beneficiaries,
    this.isBeneficiaryMaxReached,
  );
  final List<BeneficiaryModel>? beneficiaries;
  final bool? isBeneficiaryMaxReached;

  @override
  List<Object?> get props => <Object?>[
        beneficiaries,
        isBeneficiaryMaxReached,
      ];
}
