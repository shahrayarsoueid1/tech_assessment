import 'package:base_common/app/network/base_data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/domain/use_case/put_diposite_usecase.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/use_case/top_up_usecase.dart';
import 'package:topup_app/app/features/user_balance/user/domain/entity/user_entity.dart';
import 'package:topup_app/app/features/user_balance/user/domain/use_case/get_user_usecase.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_event.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_state.dart';

class GetTopUpUserBloc extends Bloc<RemoteUserEvent, RemoteUserState> {
  GetTopUpUserBloc(
      this._getUserUseCase, this._putDipositeUsecase, this._topUpUsecase)
      : super(const GetUserLoading()) {
    on<GetUserEvent>(_onGetUserEvent);
    on<PutDipositeEvent>(_onDipositerEvent);
    on<TopUpEvent>(_onTopUpEvent);
  }
  final GetUserUsecase _getUserUseCase;

  final PutDipositeUsecase _putDipositeUsecase;

  final TopUpUsecase _topUpUsecase;

  Future<void> _onGetUserEvent(
      GetUserEvent event, Emitter<RemoteUserState> emit) async {
    emit(const GetUserLoading());
    final DataState<UserEntity?> user = await _getUserUseCase();
    if (user is SuccessDataState) {
      emit(GetUserSuccess(user.data));
    } else {
      emit(GetUserError(user.error));
    }
  }

  Future<void> _onDipositerEvent(
      PutDipositeEvent event, Emitter<RemoteUserState> emit) async {
    emit(const GetUserLoading());
    final DataState<UserEntity?> user =
        await _putDipositeUsecase(params: event.amount);
    if (user is SuccessDataState) {
      emit(GetUserSuccess(user.data));
    } else {
      emit(GetUserError(user.error));
    }
  }

  Future<void> _onTopUpEvent(
      TopUpEvent event, Emitter<RemoteUserState> emit) async {
    emit(const GetUserLoading());
    final DataState<UserEntity?> user =
        await _topUpUsecase(params: event.topUpEntity);
    if (user is SuccessDataState) {
      emit(GetUserSuccess(user.data));
    } else {
      emit(GetUserError(user.error));
    }
  }
}
