import 'category.dart';
import 'customer_review.dart';
import 'menus.dart';

class RestaurantDetail {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  num rating;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    city: json['city'],
    address: json['address'],
    pictureId: json['pictureId'],
    categories: json['categories'] != null
        ? List<Category>.from(json['categories']!.map((x) => Category.fromJson(x)))
        : <Category>[],
    menus: Menus.fromJson(json['menus']),
    rating: json['rating'],
    customerReviews: json['customerReviews'] != null
        ? List<CustomerReview>.from(json['customerReviews']!.map((x) => CustomerReview.fromJson(x)))
        : <CustomerReview>[],
  );
}