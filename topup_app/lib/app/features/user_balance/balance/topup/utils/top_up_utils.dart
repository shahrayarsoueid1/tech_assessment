import 'package:topup_app/app/features/user_balance/balance/topup/datasource/model/top_up_model.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/datasource/remote/top_up_service.dart';

extension AvailableTopUps on List<double> {
  List<AvailableTopUpsChipModel> availableTops(
    double? balance,
    double? fees,
    double? userTransferAmount,
  ) =>
      _availableTopUps(
        this,
        balance,
        fees,
        userTransferAmount,
      );
}

List<AvailableTopUpsChipModel> _availableTopUps(
  List<double> availableTopUps,
  double? balance,
  double? fees,
  double? userTransferAmount,
) {
  final double currentBalance = balance ?? 0.0;
  final double currentFees = fees ?? 0.0;
  final double currentUserAmount = userTransferAmount ?? 0.0;
  return availableTopUps.map(
    (double topUpAmount) {
      final double maxPerUser =
          (MAX_AMOUNT_PER_VERIFIED_USER - currentUserAmount) + currentFees;
      return AvailableTopUpsChipModel(
          topUp: topUpAmount,
          isActive: _isTopUpActive(
            topUpAmount,
            currentFees,
            currentBalance,
            maxPerUser,
          ));
    },
  ).toList();
}

bool _isTopUpActive(
  double topUpAmount,
  double currentFees,
  double currentBalance,
  double maxPerUser,
) {
  return _isAvailableBalance(topUpAmount, currentFees, currentBalance) &&
      _isUserLimitReached(topUpAmount, currentFees, maxPerUser);
}

bool _isUserLimitReached(
  double topUpAmount,
  double currentFees,
  double maxPerUser,
) {
  return topUpAmount + currentFees <= maxPerUser;
}

bool _isAvailableBalance(
  double topUpAmount,
  double currentFees,
  double currentBalance,
) {
  return topUpAmount + currentFees <= currentBalance;
}

List<AvailableTopUpsChipModel> _availableTopUpsPerUser(
  List<double> topUps,
  List<TopUpModel> history,
  double? balance,
  double? fees,
  String? phone,
  bool includeFees,
  double? monthlyTransferPerUser,
) {
  double userTransferAmount = 0.0;

  for (final TopUpModel value in history) {
    if (phone == value.phone) {
      userTransferAmount = userTransferAmount + (value.balance ?? 0.0);
    }
  }
  return _availableTopUps(
    topUps,
    balance,
    fees,
    userTransferAmount,
  );
}

extension AvailableTopUpsPerUser on List<TopUpModel> {
  List<AvailableTopUpsChipModel> availableTopsPerUser(
    List<double> topUps,
    double? balance,
    double? fees,
    String? phone,
    bool includeFees,
    double? monthlyTransferPerUser,
  ) =>
      _availableTopUpsPerUser(
        topUps,
        this,
        balance,
        fees,
        phone,
        includeFees,
        monthlyTransferPerUser,
      );
}

double getFullAmount(
  double? balance,
  double? fees,
) {
  return (balance ?? 0.0) + (fees ?? 0.0);
}

class AvailableTopUpsChipModel {
  AvailableTopUpsChipModel({
    required this.topUp,
    required this.isActive,
  });

  final double topUp;
  final bool isActive;
}
