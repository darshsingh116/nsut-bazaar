

class HomeState {}

class HomeInitial extends HomeState {}

class HomeGotData extends HomeState {
  final Map<String, dynamic> data;

  HomeGotData({required this.data});
}
