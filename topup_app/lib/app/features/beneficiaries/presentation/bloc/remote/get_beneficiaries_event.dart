import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';

sealed class RemoteBeneficiariesEvent {
  RemoteBeneficiariesEvent();
}

class GetBeneficiariesEvent extends RemoteBeneficiariesEvent {
  GetBeneficiariesEvent();
}

class PutBeneficiaryEvent extends RemoteBeneficiariesEvent {
  PutBeneficiaryEvent(this.beneficiaryModel);
  final BeneficiaryModel beneficiaryModel;
}
