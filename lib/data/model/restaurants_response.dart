import 'package:my_restaurant/data/model/restaurant.dart';

class RestaurantsResponse {
  bool error;
  String? message;
  int? count;
  List<Restaurant> restaurants;

  RestaurantsResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantsResponse(
        error: json['error'],
        message: json['message'],
        count: json['count'],
        restaurants: json['restaurants'] != null
            ? List<Restaurant>.from(
                json['restaurants']!.map((x) => Restaurant.fromJson(x)))
            : <Restaurant>[]);
  }
}
