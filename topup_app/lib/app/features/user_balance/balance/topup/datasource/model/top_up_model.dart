import 'package:topup_app/app/features/user_balance/balance/topup/domain/entity/top_up_entity.dart';

class TopUpModel extends TopUpEntity {
  const TopUpModel(
    String? name,
    String? phone,
    double? balance,
    String? currency,
    double? fees,
  ) : super(
          name,
          phone,
          balance,
          currency,
          fees,
        );

  factory TopUpModel.fromJson(Map<String, dynamic> map) {
    final String? name = map['name'] as String?;
    final String? phone = map['phone'] as String?;
    final double? balance = map['balance'] as double?;
    final String? currency = map['currency'] as String?;
    final double? fees = map['fees'] as double?;
    return TopUpModel(
      name,
      phone,
      balance,
      currency,
      fees,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'phone': phone,
        'balance': balance,
        'currency': currency,
        'fees': fees,
      };
}
