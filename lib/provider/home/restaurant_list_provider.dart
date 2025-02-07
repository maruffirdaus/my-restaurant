import 'package:flutter/cupertino.dart';
import 'package:my_restaurant/provider/home/restaurant_list_result_state.dart';

import '../../data/remote/api_service.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestaurantListResultState _resultState = RestaurantListNoneState();
  RestaurantListResultState get resultState => _resultState;

  RestaurantListProvider(this._apiService);

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> searchRestaurants(String query) async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiService.searchRestaurants(query);

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }
}