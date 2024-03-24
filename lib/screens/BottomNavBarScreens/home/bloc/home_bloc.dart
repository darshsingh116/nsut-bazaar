import 'package:bloc/bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/home/bloc/home_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/home/bloc/home_state.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEventGetData>((event, emit) async {
      final ProductFirestore productFirestore = new ProductFirestore(event.firebaseRepository.firebaseFirestore);
      final data = await productFirestore.getCountsAndData();
      emit(HomeGotData(data: data));
    });
  }
}
