import 'customer_review.dart';

class CustomerReviewListResponse {
  bool error;
  String? message;
  List<CustomerReview> customerReviews;

  CustomerReviewListResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory CustomerReviewListResponse.fromJson(Map<String, dynamic> json) {
    return CustomerReviewListResponse(
        error: json['error'],
        message: json['message'],
        customerReviews: json['customerReviews'] != null
            ? List<CustomerReview>.from(json['customerReviews']!.map((x) => CustomerReview.fromJson(x)))
            : <CustomerReview>[]
    );
  }
}