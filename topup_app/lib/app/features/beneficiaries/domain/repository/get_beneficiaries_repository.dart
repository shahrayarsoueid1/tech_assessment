import 'package:base_common/app/network/base_data_state.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiaries_model.dart';

abstract class GetBeneficiariesRepository {
  Future<DataState<BeneficiariesModel?>> getBeneficiaries();
}
