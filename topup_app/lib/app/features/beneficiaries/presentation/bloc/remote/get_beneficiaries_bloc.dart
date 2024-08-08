import 'package:base_common/app/network/base_data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:topup_app/app/features/beneficiaries/domain/entity/beneficiaries_entity.dart';
import 'package:topup_app/app/features/beneficiaries/domain/usecase/get_beneficiaries_usecase.dart';
import 'package:topup_app/app/features/beneficiaries/domain/usecase/put_beneficiaries_usecase.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_event.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_state.dart';

class GetTopUpBeneficiariesBloc
    extends Bloc<RemoteBeneficiariesEvent, RemoteBeneficiariesState> {
  GetTopUpBeneficiariesBloc(
      this.getBeneficiariesUseCase, this.putBeneficiariesUsecase)
      : super(const GetBeneficiariesLoading()) {
    on<GetBeneficiariesEvent>(_onGetBeneficiariesEvent);
    on<PutBeneficiaryEvent>(_onPutBeneficiaryEvent);
  }
  final GetBeneficiariesUsecase getBeneficiariesUseCase;

  final PutBeneficiariesUsecase putBeneficiariesUsecase;

  Future<void> _onGetBeneficiariesEvent(GetBeneficiariesEvent event,
      Emitter<RemoteBeneficiariesState> emit) async {
    emit(const GetBeneficiariesLoading());
    final DataState<BeneficiariesEntity?> beneficiaries =
        await getBeneficiariesUseCase();
    if (beneficiaries is SuccessDataState) {
      emit(GetBeneficiariesSuccess(beneficiaries.data));
    } else {
      emit(GetBeneficiariesError(beneficiaries.error));
    }
  }

  Future<void> _onPutBeneficiaryEvent(
      PutBeneficiaryEvent event, Emitter<RemoteBeneficiariesState> emit) async {
    emit(const GetBeneficiariesLoading());
    final DataState<BeneficiariesEntity?> beneficiaries =
        await putBeneficiariesUsecase(params: event.beneficiaryModel);
    if (beneficiaries is SuccessDataState) {
      emit(GetBeneficiariesSuccess(beneficiaries.data));
    } else {
      emit(GetBeneficiariesError(beneficiaries.error));
    }
  }
}
