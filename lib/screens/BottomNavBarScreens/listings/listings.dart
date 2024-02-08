import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nsutbazaar/models/ProductModel.dart'; // Import your ProductModel
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  @override
  Widget build(BuildContext context) {
    final listingsBloc = context.read<ListingsBloc>();
    final firebaseRepository = context.read<FirebaseRepository>();

    return BlocConsumer<ListingsBloc, ListingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ListingsStateInitial) {
          listingsBloc.add(
              ListingsEventGetAllList(firebaseRepository: firebaseRepository));
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onSubmitted: (searchParameter) {
                  listingsBloc.add(
              ListingsEventGetSearchedList(firebaseRepository: firebaseRepository, searchParameter: searchParameter));
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return [SizedBox.shrink()]; // This will ensure no suggestion bar is shown
            }
          ),
        ),
                BlocBuilder<ListingsBloc, ListingsState>(
                  builder: (context, state) {
                    if (state is ListingsStateLoading ||
                        state is ListingsStateInitial) {
                      return CircularProgressIndicator();
                    } else if (state is ListingsStateGotList) {
                      if (state.productList.isEmpty) {
                        return Text('No products available');
                      } else {
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: state.productList.length,
                            itemBuilder: (context, index) {
                              ProductModel product = state.productList[index];
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Product Name: ${product.productName}'),
                                    Text('Price: ${product.price}'),
                                    Text('Description: ${product.description}'),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                    return Text("Error Out of States");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
