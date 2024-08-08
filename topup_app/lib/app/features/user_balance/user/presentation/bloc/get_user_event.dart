import 'package:topup_app/app/features/user_balance/balance/topup/domain/entity/top_up_entity.dart';

sealed class RemoteUserEvent {
  RemoteUserEvent();
}

class GetUserEvent extends RemoteUserEvent {
  GetUserEvent();
}

class PutDipositeEvent extends RemoteUserEvent {
  PutDipositeEvent(this.amount);
  final double amount;
}

class TopUpEvent extends RemoteUserEvent {
  TopUpEvent(this.topUpEntity);
  final TopUpEntity topUpEntity;
}
