import 'package:flutter/foundation.dart';
import 'package:restauran_app/api/api_service.dart';
import 'package:restauran_app/model/restaurantDetail.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({@required this.apiService, this.id}) {
    _fetchDetailRestaurant();
  }

  RestaurantDetail _restaurantDetail;
  String _message = '';
  ResultState _state;


  RestaurantDetail get restaurantDetail => _restaurantDetail;
  String get message => _message;
  ResultState get state => _state;


  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void refresh(){
    _fetchDetailRestaurant();
  }

}