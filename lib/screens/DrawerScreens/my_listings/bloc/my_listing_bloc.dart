import 'package:nsutbazaar/screens/DrawerScreens/my_listings/bloc/my_listing_event.dart';
import 'package:nsutbazaar/screens/DrawerScreens/my_listings/bloc/my_listing_state.dart';
import 'package:bloc/bloc.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';

class AuthBloc extends Bloc<ListingEvent, ListingState> {
  AuthBloc() : super(ListingStateInitial()) {


    on<ListingEventGetData>((event, emit) async {

      final productFirestore =
        new ProductFirestore(event.firebaseRepository.firebaseFirestore);

    });
  }
}
