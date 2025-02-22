import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_restaurant/data/model/restaurant.dart';
import 'package:my_restaurant/data/model/restaurants_response.dart';
import 'package:my_restaurant/data/remote/api_service.dart';
import 'package:my_restaurant/provider/restaurants/restaurants_provider.dart';
import 'package:my_restaurant/provider/restaurants/restaurants_result_state.dart';

import 'restaurants_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;
  late RestaurantsProvider provider;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantsProvider(mockApiService);
  });

  test('The initial state of the provider must be defined', () {
    expect(
        provider.resultState.runtimeType, RestaurantsNoneState().runtimeType);
  });

  test(
      'Should return a list of restaurants when the API data fetch is successful',
      () async {
    final restaurant = Restaurant(
        id: 'rqdv5juczeskfw1e867',
        name: 'Melting Pot',
        description: '...',
        pictureId: '14',
        city: 'Medan',
        rating: 4.2);

    when(mockApiService.getRestaurants())
        .thenAnswer((_) => Future.value(RestaurantsResponse(
              error: false,
              message: 'success',
              count: 1,
              restaurants: [
                restaurant,
              ],
            )));

    await provider.getRestaurants();

    expect(provider.resultState.runtimeType,
        RestaurantsLoadedState([restaurant]).runtimeType);
  });

  test('Should return an error when the API data fetch fails', () async {
    const String error = 'Failed to load restaurants';

    when(mockApiService.getRestaurants()).thenAnswer((_) {
      throw Exception(error);
    });

    await provider.getRestaurants();

    expect(provider.resultState.runtimeType,
        RestaurantsErrorState(error).runtimeType);
  });
}
