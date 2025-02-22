import 'package:flutter/cupertino.dart';
import 'package:my_restaurant/data/local/sqlite_service.dart';
import 'package:my_restaurant/data/model/restaurant.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final SqliteService _service;
  String? _message;
  String? get message => _message;
  List<Restaurant>? _restaurants;
  List<Restaurant>? get restaurants => _restaurants;

  LocalDatabaseProvider(this._service);

  Future<void> addRestaurant(Restaurant restaurant) async {
    try {
      final result = await _service.insert(restaurant);
      final isError = result == 0;

      if (isError) {
        _message = 'Failed to add restaurant';
      } else {
        _message = null;
      }
    } catch (e) {
      _message = 'Failed to add restaurant';
    }

    notifyListeners();
  }

  Future<void> getRestaurants() async {
    try {
      final result = await _service.getRestaurants();

      _message = null;
      _restaurants = result;
    } catch (e) {
      _message = 'Failed to get restaurants';
    }

    notifyListeners();
  }

  Future<void> removeRestaurant(String id) async {
    try {
      final result = await _service.delete(id);
      final isError = result == 0;

      if (isError) {
        _message = 'Failed to remove restaurant';
      } else {
        _message = null;
      }
    } catch (e) {
      _message = 'Failed to remove restaurant';
    }

    notifyListeners();
  }
}
