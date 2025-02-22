import '../../data/model/restaurant.dart';

sealed class RestaurantsResultState {}

class RestaurantsNoneState extends RestaurantsResultState {}

class RestaurantsLoadingState extends RestaurantsResultState {}

class RestaurantsErrorState extends RestaurantsResultState {
  final String? error;

  RestaurantsErrorState(this.error);
}

class RestaurantsLoadedState extends RestaurantsResultState {
  final List<Restaurant> data;

  RestaurantsLoadedState(this.data);
}
