import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/datasource/model/top_up_model.dart';
import 'package:topup_app/app/features/user_balance/user/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
    String? name,
    String? phone,
    double? balance,
    String? currency,
    double? fees,
    bool isVerified,
    List<BeneficiaryModel>? beneficiaries,
    List<double> topUps,
    List<TopUpModel> history,
    double? monthlyTransfer,
    double? monthlyTransferPerUser,
  ) : super(
          name,
          phone,
          balance,
          currency,
          fees,
          isVerified,
          beneficiaries,
          topUps,
          history,
          monthlyTransfer,
          monthlyTransferPerUser,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    final String? name = map['name'] as String?;
    final String? phone = map['phone'] as String?;
    final double? balance = map['balance'] as double?;
    final String? currency = map['currency'] as String?;
    final double? fees = map['fees'] as double?;
    final bool isVerified = map['isVerified'];
    final double? monthlyTransfer = map['monthlyTransfer'];
    final double? monthlyTransferPerUser = map['monthlyTransferPerUser'];
    final List<BeneficiaryModel> beneficiariesData =
        (map['beneficiaries'] as List<dynamic>?)
                ?.map(
                  (dynamic value) => BeneficiaryModel.fromJson(
                    value as Map<String, dynamic>,
                  ),
                )
                .toList() ??
            <BeneficiaryModel>[];

    final List<double> availableTopUp =
        (map['availableTopUps'] as List<dynamic>?)
                ?.map(
                  (dynamic value) => value as double,
                )
                .toList() ??
            <double>[];

    final List<TopUpModel> topUpHistory = (map['history'] as List<dynamic>?)
            ?.map(
              (dynamic value) => TopUpModel.fromJson(
                value as Map<String, dynamic>,
              ),
            )
            .toList() ??
        <TopUpModel>[];

    return UserModel(
      name,
      phone,
      balance,
      currency,
      fees,
      isVerified,
      beneficiariesData,
      availableTopUp,
      topUpHistory,
      monthlyTransfer,
      monthlyTransferPerUser,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'phone': phone,
        'balance': balance,
        'currency': currency,
        'fees': fees,
        'isVerified': isVerified,
        'beneficiaries': beneficiaries,
        'availableTopUps': availableTopUp,
        'history': history,
        'monthlyTransfer': monthlyTransfer,
        'monthlyTransferPerUser': monthlyTransferPerUser,
      };
}
