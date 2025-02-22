import 'customer_review.dart';

class RestaurantDetail {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menu menu;
  double rating;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menu,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        address: json['address'],
        pictureId: json['pictureId'],
        categories: json['categories'] != null
            ? List<Category>.from(
                json['categories']!.map((x) => Category.fromJson(x)))
            : <Category>[],
        menu: Menu.fromJson(json['menus']),
        rating: json['rating'].toDouble(),
        customerReviews: json['customerReviews'] != null
            ? List<CustomerReview>.from(
                json['customerReviews']!.map((x) => CustomerReview.fromJson(x)))
            : <CustomerReview>[],
      );
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json['name'],
      );
}

class Menu {
  List<Food> foods;
  List<Drink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: json['foods'] != null
            ? List<Food>.from(json['foods']!.map((x) => Food.fromJson(x)))
            : <Food>[],
        drinks: json['drinks'] != null
            ? List<Drink>.from(json['drinks']!.map((x) => Drink.fromJson(x)))
            : <Drink>[],
      );
}

class Food {
  String name;

  Food({
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json['name'],
      );
}

class Drink {
  String name;

  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json['name'],
      );
}
