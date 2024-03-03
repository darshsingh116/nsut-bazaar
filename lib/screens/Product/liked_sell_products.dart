import 'package:flutter/material.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/widgets/cards/sell_listing_card.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:nsutbazaar/widgets/core/secondary_appBar.dart';

class LikedSellProductScreen extends StatefulWidget {
  @override
  _LikedSellProductScreenState createState() => _LikedSellProductScreenState();
}

class _LikedSellProductScreenState extends State<LikedSellProductScreen> {
  @override
  Widget build(BuildContext context) {
    final localData = context.read<LocalData>();
    final listingsBloc = context.read<ListingsBloc>();

    return WillPopScope(
      onWillPop: () async {
        listingsBloc.emit(ListingsStateInitial());
        return true; // Allow back navigation
      },
      child: backgroundContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: secondaryAppBar("Liked", context),
          body: ListView.builder(
            itemCount: localData.likedSellProductModelList.length,
            itemBuilder: (BuildContext context, int index) {
              final SellProductModel product =
                  localData.likedSellProductModelList[index];
              return SellListCard(
                sellProductModel: product,
                localData: localData,
              );
            },
          ),
        ),
      ),
    );
  }
}
