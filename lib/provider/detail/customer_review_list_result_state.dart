import '../../data/remote/response/customer_review.dart';

sealed class CustomerReviewListResultState {}

class CustomerReviewListNoneState extends CustomerReviewListResultState {}

class CustomerReviewListLoadingState extends CustomerReviewListResultState {}

class CustomerReviewListErrorState extends CustomerReviewListResultState {
  final String? error;

  CustomerReviewListErrorState(this.error);
}

class CustomerReviewListLoadedState extends CustomerReviewListResultState {
  final List<CustomerReview> data;

  CustomerReviewListLoadedState(this.data);
}