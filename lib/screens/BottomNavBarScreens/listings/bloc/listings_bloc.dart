import 'package:bloc/bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';

class ListingsBloc extends Bloc<ListingsEvent, ListingsState> {
  ListingsBloc() : super(ListingsStateInitial()) {
    on<ListingsEventGetAllList>((event, emit) async {
      emit(ListingsStateLoading());
      print("inside listing bloc get event all list1");
      final productFirestore =
          ProductFirestore(event.firebaseRepository.firebaseFirestore);
      print("inside listing bloc get event all list2");
      final productList = await productFirestore.getAllSellProducts();
      print("inside listing bloc get event all list3");
      emit(ListingsStateGotList(productList: productList));
    });

    on<ListingsEventGetSearchedList>((event, emit) async {
      final searchParameter = event.searchParameter;
      emit(ListingsStateLoading());
      final productFirestore =
          ProductFirestore(event.firebaseRepository.firebaseFirestore);
      final productList = await productFirestore.getAllSellProducts();

      final filteredProducts = productList
          .where((product) =>
              product.description
                  .toLowerCase()
                  .contains(searchParameter.toLowerCase()) ||
              product.productName
                  .toLowerCase()
                  .contains(searchParameter.toLowerCase()))
          .toList();
      emit(ListingsStateGotList(productList: filteredProducts));
    });
  }
}
