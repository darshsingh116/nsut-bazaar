import 'package:bloc/bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/blocLatestPost/latest_post_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/blocLatestPost/latest_post_state.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';

class LatestPostBloc extends Bloc<LatestPostEvent, LatestPostState> {
  LatestPostBloc() : super(LatestPostStateInitial()) {
    on<LatestPostEventGetAllList>((event, emit) async {
      emit(LatestPostStateLoading());
      print("koko desu");
      try {
        final productFirestore =
            ProductFirestore(event.firebaseRepository.firebaseFirestore);
        final productList = await productFirestore.getAllSellProducts();
        emit(LatestPostStateGotList(productList: productList));
      } catch (e) {
        print("THIS IS DEV CAUGHT ERROR : ${e}");
      }
    });

    on<LatestPostEventInitialize>((event, emit) async {
      emit(LatestPostStateInitial());
    });
  }
}
