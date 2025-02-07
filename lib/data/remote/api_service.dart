import 'dart:convert';

import 'package:my_restaurant/data/remote/response/customer_review_list_response.dart';
import 'package:my_restaurant/data/remote/response/restaurant_detail_response.dart';
import 'package:my_restaurant/data/remote/response/restaurant_list_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantListResponse> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

  Future<CustomerReviewListResponse> addReview(String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'name': name,
        'review': review,
      })
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CustomerReviewListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}