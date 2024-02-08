import 'package:nsutbazaar/models/ProductModel.dart';

abstract class RequestsState {}

class RequestsStateInitial extends RequestsState {}

class RequestsStateLoading extends RequestsState {}

class RequestsStateGotList extends RequestsState {
  final List<ProductModel> productList;

  RequestsStateGotList({required this.productList});
}
