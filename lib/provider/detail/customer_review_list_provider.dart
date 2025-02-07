import 'package:flutter/cupertino.dart';
import 'package:my_restaurant/provider/detail/customer_review_list_result_state.dart';

import '../../data/remote/api_service.dart';

class CustomerReviewListProvider extends ChangeNotifier {
  final ApiService _apiService;
  CustomerReviewListResultState _resultState = CustomerReviewListNoneState();
  CustomerReviewListResultState get resultState => _resultState;

  CustomerReviewListProvider(this._apiService);

  Future<void> addReview(String id, String name, String review) async {
    try {
      _resultState = CustomerReviewListLoadingState();
      notifyListeners();

      final result = await _apiService.addReview(id, name, review);

      if (result.error) {
        _resultState = CustomerReviewListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = CustomerReviewListLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = CustomerReviewListErrorState(e.toString());
      notifyListeners();
    }
  }

  void reset() {
    _resultState = CustomerReviewListNoneState();
    notifyListeners();
  }
}