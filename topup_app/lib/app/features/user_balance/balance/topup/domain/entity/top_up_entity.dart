import 'package:equatable/equatable.dart';

class TopUpEntity extends Equatable {
  const TopUpEntity(
    this.name,
    this.phone,
    this.balance,
    this.currency,
    this.fees,
  );
  final String? name;
  final String? phone;
  final double? balance;
  final String? currency;
  final double? fees;

  @override
  List<Object?> get props => <Object?>[name, phone, balance, currency, fees];
}
