import 'package:flutter/material.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/local_data.dart';

class SellListCardHorizontal extends StatefulWidget {
  final SellProductModel sellProductModel;
  final LocalData localData;

  const SellListCardHorizontal(
      {super.key, required this.sellProductModel, required this.localData});

  @override
  _SellListCardHorizontalState createState() => _SellListCardHorizontalState();
}

class _SellListCardHorizontalState extends State<SellListCardHorizontal> {
  bool _isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print(widget.localData.likedSellProductModelList
          .any((item) => item.imageUrl == widget.sellProductModel.imageUrl));
      _isLiked = widget.localData.likedSellProductModelList
          .any((item) => item.imageUrl == widget.sellProductModel.imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth / 2.25;
    double imageHeight = containerWidth * 1.1;
    //double containerHeight = screenHeight / 6;

    return Container(
        width: screenWidth * 0.9,
        height: screenWidth * 0.35,
        decoration: BoxDecoration(
          color: Color.fromARGB(87, 136, 136, 136),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    color: Colors.transparent,
                    height: screenWidth * 0.3,
                    width: screenWidth * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: FadeInImage.assetNetwork(
                        placeholder:
                            'assets/loading.gif', // Placeholder image asset
                        image: widget.sellProductModel.imageUrl,
                        fit: BoxFit.fill,
                        fadeInDuration: Duration(
                            milliseconds:
                                200), // Duration for fade-in animation
                        width: 10, // Specify the width of the placeholder
                        height: 10, // Specify the height of the placeholder
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Text(
                                  widget.sellProductModel.productName
                                      .toTitleCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '₹${widget.sellProductModel.price.toString()}',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: screenWidth * 0.13,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(
                                widget.sellProductModel.description.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Container(
                                height: containerWidth * 0.2,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: IconButton(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        icon: Icon(
                                          _isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: _isLiked
                                              ? Colors.red
                                              : Colors.red,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isLiked = !_isLiked;
                                            if (_isLiked) {
                                              widget.localData.addData(
                                                  widget.sellProductModel);
                                            } else {
                                              widget.localData.removeData(
                                                  widget.sellProductModel);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: IconButton(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        icon: Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.yellow,
                                          size: 30,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
