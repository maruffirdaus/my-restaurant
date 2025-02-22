import 'customer_review.dart';

class CustomerReviewsResponse {
  bool error;
  String? message;
  List<CustomerReview> customerReviews;

  CustomerReviewsResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory CustomerReviewsResponse.fromJson(Map<String, dynamic> json) {
    return CustomerReviewsResponse(
        error: json['error'],
        message: json['message'],
        customerReviews: json['customerReviews'] != null
            ? List<CustomerReview>.from(
                json['customerReviews']!.map((x) => CustomerReview.fromJson(x)))
            : <CustomerReview>[]);
  }
}
