import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:topup_app/app/features/user_balance/user/domain/entity/user_entity.dart';

sealed class RemoteUserState extends Equatable {
  const RemoteUserState({this.userEntity, this.error});
  final UserEntity? userEntity;
  final DioException? error;

  @override
  List<Object?> get props => <Object?>[UserEntity];
}

class GetUserLoading extends RemoteUserState {
  const GetUserLoading();
}

class GetUserSuccess extends RemoteUserState {
  const GetUserSuccess(UserEntity? userEntity) : super(userEntity: userEntity);
}

class GetUserError extends RemoteUserState {
  const GetUserError(DioException? error) : super(error: error);
}
