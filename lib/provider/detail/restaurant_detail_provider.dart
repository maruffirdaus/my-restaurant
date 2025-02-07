import 'package:flutter/cupertino.dart';
import 'package:my_restaurant/provider/detail/restaurant_detail_result_state.dart';

import '../../data/remote/api_service.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  RestaurantDetailResultState get resultState => _resultState;

  RestaurantDetailProvider(this._apiService);

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}