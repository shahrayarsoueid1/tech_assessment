import 'package:equatable/equatable.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/datasource/model/top_up_model.dart';

class UserEntity extends Equatable {
  const UserEntity(
    this.name,
    this.phone,
    this.balance,
    this.currency,
    this.fees,
    this.isVerified,
    this.beneficiaries,
    this.availableTopUp,
    this.history,
    this.monthlyTransfer,
    this.monthlyTransferPerUser,
  );
  final String? name;
  final String? phone;
  final double? balance;
  final String? currency;
  final double? fees;
  final bool isVerified;
  final List<BeneficiaryModel>? beneficiaries;
  final List<double> availableTopUp;
  final List<TopUpModel> history;
  final double? monthlyTransfer;
  final double? monthlyTransferPerUser;

  @override
  List<Object?> get props => <Object?>[
        name,
        phone,
        balance,
        currency,
        fees,
        isVerified,
        beneficiaries,
        availableTopUp,
        history,
        monthlyTransfer,
        monthlyTransferPerUser,
      ];
}
