import 'package:my_restaurant/data/remote/response/restaurant_detail.dart';

class RestaurantDetailResponse {
  bool error;
  String? message;
  RestaurantDetail restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) => RestaurantDetailResponse(
    error: json['error'],
    message: json['message'],
    restaurant: RestaurantDetail.fromJson(json['restaurant']),
  );
}