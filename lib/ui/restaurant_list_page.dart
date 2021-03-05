import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';
import 'package:restauran_app/ui/restaurant_detail_page.dart';
import 'package:restauran_app/widget/card_restaurant.dart';
import 'package:restauran_app/common/navigation.dart';

class RestaurantListPage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.restaurantResult.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.restaurantResult.restaurants[index];
              return CardRestaurant(
                restaurant: restaurant,
                  onPressed: ()
                   {
                     Navigation.intentWithData(RestaurantDetailPage.routeName, restaurant);
                   }
              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
               padding: EdgeInsets.all(20),
               child: Center(
                 child: Text("Terjadi kesalahan.. \nMohon aktifkan atau restart koneksi internet anda untuk memuat kembali",
                 textAlign: TextAlign.center,)
               ),
             ),
             RaisedButton(
               child: Text("Refresh Data"),
               onPressed: () {
                 state.refresh();
               },
             ),
           ],
         );
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildList(context),
    );
  }
}