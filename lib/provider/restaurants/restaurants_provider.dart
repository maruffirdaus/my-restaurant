import 'package:flutter/cupertino.dart';
import 'package:my_restaurant/provider/restaurants/restaurants_result_state.dart';

import '../../data/remote/api_service.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestaurantsResultState _resultState = RestaurantsNoneState();
  RestaurantsResultState get resultState => _resultState;

  RestaurantsProvider(this._apiService);

  Future<void> getRestaurants() async {
    try {
      _resultState = RestaurantsLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurants();

      if (result.error) {
        _resultState = RestaurantsErrorState('Failed to load restaurants');
      } else {
        _resultState = RestaurantsLoadedState(result.restaurants);
      }
    } catch (e) {
      _resultState = RestaurantsErrorState('Failed to load restaurants');
    }

    notifyListeners();
  }

  Future<void> searchRestaurants(String query) async {
    try {
      _resultState = RestaurantsLoadingState();
      notifyListeners();

      final result = await _apiService.searchRestaurants(query);

      if (result.error) {
        _resultState = RestaurantsErrorState('Failed to search restaurants');
      } else {
        _resultState = RestaurantsLoadedState(result.restaurants);
      }
    } catch (e) {
      _resultState = RestaurantsErrorState('Failed to search restaurants');
    }

    notifyListeners();
  }
}
