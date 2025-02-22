import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_restaurant/data/remote/api_service.dart';
import 'package:my_restaurant/provider/restaurant_detail/restaurant_detail_provider.dart';
import 'package:my_restaurant/provider/restaurant_detail/restaurant_detail_result_state.dart';

import 'restaurant_detail_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;
  late RestaurantDetailProvider provider;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantDetailProvider(mockApiService);
  });

  test('The initial state of the provider must be defined', () {
    expect(provider.resultState.runtimeType,
        RestaurantDetailNoneState().runtimeType);
  });

  test('Should return an error when the API data fetch fails', () async {
    const String restaurantId = 'rqdv5juczeskfw1e867';
    const String error = 'Failed to load restaurant details';

    when(mockApiService.getRestaurantDetails(restaurantId)).thenAnswer((_) {
      throw Exception(error);
    });

    await provider.getRestaurantDetails(restaurantId);

    expect(provider.resultState.runtimeType,
        RestaurantDetailErrorState(error).runtimeType);
  });
}
