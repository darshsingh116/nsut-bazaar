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
      event.localData.allSellProductModelList = productList;
      emit(ListingsStateGotList(productList: productList));
    });

    on<ListingsEventInitialize>((event, emit) async {
      emit(ListingsStateInitial());
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
      emit(ListingsStateGotSearchedList(productList: filteredProducts));
    });

    on<ListingsEventGetCategorySearchedList>((event, emit) async {
      final category = event.category;
      emit(ListingsStateLoading());
      final productFirestore =
          ProductFirestore(event.firebaseRepository.firebaseFirestore);
      final productList = await productFirestore.getAllSellProducts();
      print(category.toLowerCase());
      if (category != null &&
          category.isNotEmpty &&
          category.toLowerCase() != "all") {
        final filteredProducts = productList.where((product) {
          if (category.toLowerCase() == 'books') {
            return product.isBooks;
          } else if (category.toLowerCase() == 'sports') {
            return product.isSports;
          } else if (category.toLowerCase() == 'academic tools') {
            return product.isAcademicTool;
          } else if (category.toLowerCase() == 'others') {
            return product.isOthers;
          }
          return false; // No match found, so exclude this product
        }).toList();

        emit(ListingsStateGotSearchedList(productList: filteredProducts));
      } else {
        print("all");
        emit(ListingsStateGotSearchedList(productList: productList));
      }
    });
  }
}
