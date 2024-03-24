import 'package:nsutbazaar/models/SellProductModel.dart';

abstract class LatestPostState {}

class LatestPostStateInitial extends LatestPostState {}

class LatestPostStateLoading extends LatestPostState {}

class LatestPostStateGotList extends LatestPostState {
  final List<SellProductModel> productList;

  LatestPostStateGotList({required this.productList});
}

