import 'package:nsutbazaar/models/SellProductModel.dart';

abstract class ListingsState {}

class ListingsStateInitial extends ListingsState {}

class ListingsStateLoading extends ListingsState {}

class ListingsStateGotList extends ListingsState {
  final List<SellProductModel> productList;

  ListingsStateGotList({required this.productList});
}
