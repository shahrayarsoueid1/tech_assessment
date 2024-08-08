import 'package:dio/dio.dart';

abstract class DataState<T> {
  const DataState({this.data, this.error});
  final T? data;
  final DioException? error;
}

class SuccessDataState<T> extends DataState<T> {
  const SuccessDataState(T data) : super(data: data);
}

class ErrorDataState<T> extends DataState<T> {
  const ErrorDataState(DioException error) : super(error: error);
}
