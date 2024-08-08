import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:topup_app/app/features/beneficiaries/domain/entity/beneficiaries_entity.dart';

sealed class RemoteBeneficiariesState extends Equatable {
  const RemoteBeneficiariesState({this.beneficiariesEntity, this.error});
  final BeneficiariesEntity? beneficiariesEntity;
  final DioException? error;

  @override
  List<Object?> get props => <Object?>[beneficiariesEntity];
}

class GetBeneficiariesLoading extends RemoteBeneficiariesState {
  const GetBeneficiariesLoading();
}

class GetBeneficiariesSuccess extends RemoteBeneficiariesState {
  const GetBeneficiariesSuccess(BeneficiariesEntity? beneficiariesEntity)
      : super(beneficiariesEntity: beneficiariesEntity);
}

class GetBeneficiariesError extends RemoteBeneficiariesState {
  const GetBeneficiariesError(DioException? error) : super(error: error);
}
