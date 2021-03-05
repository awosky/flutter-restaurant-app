import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/common/navigation.dart';
import 'package:restauran_app/provider/database_provider.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';
import 'package:restauran_app/ui/restaurant_detail_page.dart';
import 'package:restauran_app/widget/card_restaurant.dart';

class FavoritesPage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardRestaurant(
                restaurant: provider.favorites[index],
                onPressed: ()
                {
                  Navigation.intentWithData(RestaurantDetailPage.routeName, provider.favorites[index]);
                }
              );
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }
}