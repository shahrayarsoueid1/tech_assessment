import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';
import 'package:topup_app/app/features/beneficiaries/domain/entity/beneficiaries_entity.dart';

class BeneficiariesModel extends BeneficiariesEntity {
  const BeneficiariesModel({
    List<BeneficiaryModel>? beneficiaries,
    bool? isMaxBeneficiaryReached,
  }) : super(beneficiaries, isMaxBeneficiaryReached);

  factory BeneficiariesModel.fromJson(Map<String, dynamic> map) {
    final bool isBeneficiaryMaxReached =
        map['isBeneficiaryMaxReached'] ?? false;
    final List<dynamic>? beneficiariesData =
        map['beneficiaries'] as List<dynamic>?;
    final List<BeneficiaryModel> beneficiaries = beneficiariesData != null
        ? beneficiariesData
            .map(
              (dynamic beneficiariesData) => BeneficiaryModel.fromJson(
                  beneficiariesData as Map<String, dynamic>),
            )
            .toList()
        : <BeneficiaryModel>[];
    return BeneficiariesModel(
      beneficiaries: beneficiaries,
      isMaxBeneficiaryReached: isBeneficiaryMaxReached,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'beneficiaries':
            beneficiaries?.map((BeneficiaryModel beneficiariesData) {
          beneficiariesData.toJson();
        }).toList()
      };
}
