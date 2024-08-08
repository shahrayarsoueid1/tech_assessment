import 'package:equatable/equatable.dart';

class BeneficiaryModel extends Equatable {
  const BeneficiaryModel(
    this.name,
    this.phone,
  );

  factory BeneficiaryModel.fromJson(Map<String, dynamic> data) {
    final String? name = data['name'] as String?;
    final String? phone = data['phone'] as String?;
    return BeneficiaryModel(name, phone);
  }

  final String? name;
  final String? phone;

  @override
  List<Object?> get props => <Object?>[name, phone];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'phone': phone,
      };
}
