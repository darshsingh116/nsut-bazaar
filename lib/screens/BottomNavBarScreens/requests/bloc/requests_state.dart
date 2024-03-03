import 'package:nsutbazaar/models/RequestProductModel.dart';

abstract class RequestsState {}

class RequestsStateInitial extends RequestsState {}

class RequestsStateLoading extends RequestsState {}

class RequestsStateGotList extends RequestsState {
  final List<RequestProductModel> productList;

  RequestsStateGotList({required this.productList});
}
