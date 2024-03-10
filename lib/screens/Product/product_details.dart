import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  final SellProductModel product;
  final LocalData localData;

  ProductDetails({required this.product, required this.localData});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isLiked = false;
  List<String> categories = [];

  void launchWhatsApp(String phone) async {// Convert the URL string to a Uri object
    try {
      String url = 'whatsapp://send?phone=$phone';
      Uri uri = Uri.parse(url);
      launchUrl(uri);
    } catch (e) {
      print(e);
      try {
        String url = 'whatsapp://send?phone=+$phone';
        Uri uri = Uri.parse(url);
        launchUrl(uri);
      } catch (e) {
        print(e);
        try {
          String url = 'whatsapp://send?phone=+91$phone';
          Uri uri = Uri.parse(url);
          launchUrl(uri);
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLiked = widget.localData.likedSellProductModelList
          .any((item) => item.imageUrl == widget.product.imageUrl);
    });

    if (widget.product.isBooks) {
      categories.add("Book");
    } else if (widget.product.isSports) {
      categories.add("Sports");
    } else if (widget.product.isAcademicTool) {
      categories.add("Academic Tool");
    } else {
      categories.add("Others");
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingsBloc = context.read<ListingsBloc>();

    return WillPopScope(
      onWillPop: () async {
        listingsBloc.emit(ListingsStateInitial());
        return true;
      },
      child: backgroundContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Product Details'),
            backgroundColor: Colors.transparent,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                listingsBloc.emit(ListingsStateInitial());
                Navigator.of(context).pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300.h,
                  width: double.infinity,
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.product.productName.toTitleCase()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked
                              ? PurpleTheme.LightPurpleColor
                              : const Color.fromARGB(255, 255, 255, 255),
                          size: 24.sp,
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
                  padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                  child: Text(
                    '\₹${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                //   child: Text(
                //     "Description :",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: Text(
                    "Description : ${widget.product.description}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: Container(
                    height: 32.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: Category(title: categories[index]),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: FloatingActionButton.extended(
              onPressed: () {
                launchWhatsApp(widget.product.contactNumber.toString());
              },
              label: Text('Whatsapp'),
              icon: Icon(Icons.call),
              backgroundColor: Colors.green,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String title;

  Category({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.0,
      decoration: BoxDecoration(
        color: PurpleTheme.LightPurpleColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
