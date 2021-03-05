// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:mockito/mockito.dart';
import 'package:restauran_app/api/api_service.dart';
import 'package:restauran_app/model/restauran.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';
import 'package:test/test.dart';

const apiResponse = {
  "error": false,
  "message": "success",
  "count": 20,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
    {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    }
  ]
};


const testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

class MockApiService extends Mock implements ApiService {}

void main() {
  group("Test",() {

    ApiService apiService;
    RestaurantProvider restaurantProvider;

    test('First Unit Test', () async {
      // arrange
      var restaurantProvider = RestaurantProvider(apiService: apiService);
      var testModuleName = 'Kafe';
      // act
      restaurantProvider.searchRestaurants(testModuleName);
      // assert
      var result = restaurantProvider.searchKey.contains(testModuleName);
      expect(result, true);
    });

    setUp(() {
      apiService = MockApiService();
      when(apiService.listRestaurant()).thenAnswer((_) async => RestaurantResult.fromJson(apiResponse));
      restaurantProvider = RestaurantProvider(apiService: apiService);
    });

    test('Parsing JSON Test', () async {
      var resultData = Restaurant.fromJson(testRestaurant).name;
      var resultTest = restaurantProvider.restaurantResult.restaurants.first.name;
      expect(resultData == resultTest, true);

    });
  });
}
