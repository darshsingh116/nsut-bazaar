import 'package:bloc/bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_state.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc() : super(RequestsStateInitial()) {
    
    on<RequestsEventGetAllList>((event, emit) async {
      emit(RequestsStateLoading());
      final productFirestore =
          ProductFirestore(event.firebaseRepository.firebaseFirestore);
      final productList = await productFirestore.getAllRequestProducts();

      emit(RequestsStateGotList(productList: productList));
    });

    on<RequestsEventInitialize>((event, emit) async {
      emit(RequestsStateInitial());
    });

    on<RequestsEventGetSearchedList>((event, emit) async {
      final searchParameter = event.searchParameter;
      emit(RequestsStateLoading());
      final productFirestore =
          ProductFirestore(event.firebaseRepository.firebaseFirestore);
      final productList = await productFirestore.getAllRequestProducts();

      final filteredProducts = productList.where((product) =>
    product.description.toLowerCase().contains(searchParameter.toLowerCase()) ||
    product.productName.toLowerCase().contains(searchParameter.toLowerCase())
).toList();

      emit(RequestsStateGotList(productList: filteredProducts));
    });

  }
}
