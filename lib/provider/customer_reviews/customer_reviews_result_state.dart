import '../../data/model/customer_review.dart';

sealed class CustomerReviewsResultState {}

class CustomerReviewsNoneState extends CustomerReviewsResultState {}

class CustomerReviewsLoadingState extends CustomerReviewsResultState {}

class CustomerReviewsErrorState extends CustomerReviewsResultState {
  final String? error;

  CustomerReviewsErrorState(this.error);
}

class CustomerReviewsLoadedState extends CustomerReviewsResultState {
  final List<CustomerReview> data;

  CustomerReviewsLoadedState(this.data);
}
