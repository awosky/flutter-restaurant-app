import 'package:flutter/foundation.dart';
import 'package:restauran_app/api/api_service.dart';
import 'package:restauran_app/model/restauran.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({@required this.apiService}) {
    _fetchAllRestaurant();
  }

  RestaurantResult _restaurantResult;
  RestaurantResult _restaurantSearchResult;
  String _message = '';
  ResultState _state;
  ResultState _stateSearch;
  String _searchKey = "query";
  int _isFirst = 0;

  RestaurantResult get restaurantResult => _restaurantResult;
  RestaurantResult get restaurantSearchResult => _restaurantSearchResult;
  String get message => _message;
  ResultState get state => _state;
  ResultState get stateSearch => _stateSearch;
  String get searchKey => _searchKey;
  int get isFirst => _isFirst;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void refresh(){
    _fetchAllRestaurant();
  }

  Future<RestaurantResult> fetchSearchRestaurant(String keyword) async {
      final restaurant = await ApiService().searchRestaurant(keyword);
      if (restaurant != null) {
        return _restaurantSearchResult = restaurant;
      }
  }

  void searchRestaurants(String s) {
    _searchKey = s;
    _isFirst = 1;
    notifyListeners();
  }

  void resetSearch() {
    _searchKey = "query";
    _isFirst = 0;
    notifyListeners();
  }

}