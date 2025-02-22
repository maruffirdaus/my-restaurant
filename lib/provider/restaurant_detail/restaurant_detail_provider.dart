import 'package:flutter/cupertino.dart';
import 'package:my_restaurant/provider/restaurant_detail/restaurant_detail_result_state.dart';

import '../../data/remote/api_service.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  RestaurantDetailResultState get resultState => _resultState;

  RestaurantDetailProvider(this._apiService);

  Future<void> getRestaurantDetails(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantDetails(id);

      if (result.error) {
        _resultState =
            RestaurantDetailErrorState('Failed to load restaurant details');
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
      }
    } on Exception {
      _resultState =
          RestaurantDetailErrorState('Failed to load restaurant details');
    }

    notifyListeners();
  }
}
