import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';

class ProductDetails extends StatefulWidget {
  final SellProductModel product;
  final LocalData localData;

  ProductDetails({required this.product, required this.localData});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLiked = widget.localData.likedSellProductModelList
          .any((item) => item.imageUrl == widget.product.imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    final listingsBloc = context.read<ListingsBloc>();

    return WillPopScope(
      onWillPop: () async {
        listingsBloc.emit(ListingsStateInitial());
        return true; // Allow back navigation
      },
      child: backgroundContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.productName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked
                              ? Colors.red
                              : const Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLiked = !_isLiked;
                            if (_isLiked) {
                              widget.localData.addData(widget.product);
                            } else {
                              widget.localData.removeData(widget.product);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.product.description,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // Add details action here
            },
            label: Text('Whatsapp'),
            icon: Icon(Icons.call),
            backgroundColor: Colors.green,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
