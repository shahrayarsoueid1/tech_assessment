import 'package:base_common/app/network/base_data_state.dart';

abstract class BaseUseCase<T, Params> {
  Future<DataState<T>> call({Params params});
}
