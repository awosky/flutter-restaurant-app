import 'dart:convert';
import 'package:restauran_app/model/restauran.dart';
import 'package:http/http.dart' as http;
import 'package:restauran_app/model/restaurantDetail.dart';

class ApiService {
  static final String _baseUrlList = 'https://restaurant-api.dicoding.dev/list';
  static final String _baseUrlDetail = 'https://restaurant-api.dicoding.dev/detail/';
  static final String _baseUrlSearch = 'https://restaurant-api.dicoding.dev/search?q=';

  Future<RestaurantResult> listRestaurant() async {
    final response = await http.get(_baseUrlList);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list Restaurant');
    }
  }

  Future<RestaurantDetail> detailRestaurant(String id) async {
    final response = await http.get(_baseUrlDetail+id);
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body)).restaurant;
    } else {
      throw Exception('Failed to load detail Restaurant');
    }
  }

  Future<RestaurantResult> searchRestaurant(String s) async {
    final response = await http.get(_baseUrlSearch+s);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list Restaurant');
    }
  }
}