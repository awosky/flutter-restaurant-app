import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/common/navigation.dart';
import 'package:restauran_app/model/restauran.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';
import 'package:restauran_app/ui/restaurant_detail_page.dart';
import 'package:restauran_app/widget/card_restaurant.dart';

class RestaurantSearchPage extends StatelessWidget {
 Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, RestaurantProvider data, widget)
      { return FutureBuilder(
          future: data.fetchSearchRestaurant(data.searchKey),
          builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
            var state = snapshot.connectionState;
            var isFirst = Provider.of<RestaurantProvider>(context, listen: false).isFirst;
            if (isFirst == 0) {
              return Container(
                  margin: EdgeInsets.only(top:10),
                  child: Center(
                      child: Text("Search Ready !")
                  )
              );
            } else if (isFirst == 1 && state != ConnectionState.done) {
              return Container(
                  margin: EdgeInsets.only(top:10),
                  child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
            }  else {
              if (snapshot.hasData && snapshot.data.restaurants.length > 0) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = snapshot.data.restaurants[index];
                          return CardRestaurant(
                              restaurant: restaurant,
                              onPressed: ()
                              {
                                Navigation.intentWithData(RestaurantDetailPage.routeName, restaurant);
                              }
                          );
                        }
                    );
              } else if (snapshot.hasError) {
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
                        data.refresh();
                      },
                    ),
                  ],
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text("Data pencarian tidak ditemukan",
                        textAlign: TextAlign.center,)
                  ),
                );
              }
            }
          },
        );
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