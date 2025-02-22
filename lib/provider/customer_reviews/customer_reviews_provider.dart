import 'package:flutter/cupertino.dart';

import '../../data/remote/api_service.dart';
import 'customer_reviews_result_state.dart';

class CustomerReviewsProvider extends ChangeNotifier {
  final ApiService _apiService;
  CustomerReviewsResultState _resultState = CustomerReviewsNoneState();
  CustomerReviewsResultState get resultState => _resultState;

  CustomerReviewsProvider(this._apiService);

  Future<void> addReview(String id, String name, String review) async {
    try {
      _resultState = CustomerReviewsLoadingState();
      notifyListeners();

      final result = await _apiService.addReview(id, name, review);

      if (result.error) {
        _resultState = CustomerReviewsErrorState('Failed to add review');
      } else {
        _resultState = CustomerReviewsLoadedState(result.customerReviews);
      }
    } on Exception {
      _resultState = CustomerReviewsErrorState('Failed to add review');
    }

    notifyListeners();
  }

  void reset() {
    _resultState = CustomerReviewsNoneState();
    notifyListeners();
  }
}
