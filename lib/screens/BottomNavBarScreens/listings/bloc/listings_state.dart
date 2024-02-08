import 'package:nsutbazaar/models/ProductModel.dart';

abstract class ListingsState {}

class ListingsStateInitial extends ListingsState {}

class ListingsStateLoading extends ListingsState {}

class ListingsStateGotList extends ListingsState {
  final List<ProductModel> productList;

  ListingsStateGotList({required this.productList});
}
