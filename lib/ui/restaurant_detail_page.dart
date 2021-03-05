import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/api/api_service.dart';
import 'package:restauran_app/common/styles.dart';
import 'package:restauran_app/model/restauran.dart';
import 'package:restauran_app/provider/database_provider.dart';
import 'package:restauran_app/provider/preferences_provider.dart';
import 'package:restauran_app/provider/restaurant_detail_provider.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: restaurant.id),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return Consumer<PreferencesProvider>(
                  builder: (context, provider, child) {
                    return SingleChildScrollView(
                      child: Stack(
                          children: <Widget> [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                      child: state.restaurantDetail.pictureId == null ?
                                      Container(
                                        child: Icon(Icons.error),
                                      )
                                          :
                                      Hero(
                                          tag: state.restaurantDetail.pictureId,
                                          child: Image.network(
                                            "https://restaurant-api.dicoding.dev/images/large/"+state.restaurantDetail.pictureId,
                                            height: MediaQuery.of(context).size.height * .37,
                                            width:MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          )
                                      ),
                                    ),
                                    SafeArea(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.arrow_back, color: Colors.white,),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        state.restaurantDetail.name ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(height: 7,),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,size: 13,color: provider.isDarkTheme ? darkSecondaryColor: secondaryColor,),
                                          Text(
                                            state.restaurantDetail.city ?? "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 7,),
                                      Row(
                                        children: [
                                          Icon(Icons.grade_outlined,size: 13,color: provider.isDarkTheme ? darkSecondaryColor: secondaryColor,),
                                          Text(
                                            state.restaurantDetail.rating.toString() ?? "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      Text(
                                        "Category",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 7,),
                                      state.restaurantDetail.categories.length > 0 ?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: state.restaurantDetail.categories.map((category) {
                                          return Container(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .5, color: Colors.grey),
                                                borderRadius: BorderRadius.all(Radius.circular(2))
                                            ),
                                            child: Text(
                                              category.name ?? "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ) : '',
                                      SizedBox(height: 15,),
                                      Text(
                                        "Description",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        state.restaurantDetail.description ?? "",
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(height: 15,),
                                      Text(
                                        "Menu",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        "Foods",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: state.restaurantDetail.menus.foods.map((url) {
                                            return Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Stack(
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.3,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        child: Image.asset("images/food.jpg",fit: BoxFit.cover,),
                                                      ),
                                                    ),
                                                    Positioned.fill(
                                                        child: Align(
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              url.name,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            )
                                                        )
                                                    )
                                                  ]
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        "Drinks",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: state.restaurantDetail.menus.drinks.map((url) {
                                            return Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Stack(
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.3,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        child: Image.asset("images/drink.jpg",fit: BoxFit.cover,),
                                                      ),
                                                    ),
                                                    Positioned.fill(
                                                        child: Align(
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              url.name,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            )
                                                        )
                                                    )
                                                  ]
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              child: Consumer<DatabaseProvider>(
                                  builder: (context, providerdb, child) {
                                    return FutureBuilder<bool>(
                                        future: providerdb.isFavorited(state.restaurantDetail.id),
                                        builder: (context, snapshot) {
                                          var isFavorited = snapshot.data ?? false;
                                          return isFavorited?
                                          FloatingActionButton(
                                              backgroundColor: provider.isDarkTheme ? Colors.grey: primaryColor,
                                              onPressed: () => providerdb.removeFavorite(restaurant.id),
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 28,
                                              )
                                          )
                                              :
                                          FloatingActionButton(
                                              backgroundColor: provider.isDarkTheme ? Colors.grey: primaryColor,
                                              onPressed: () => providerdb.addFavorite(restaurant),
                                              child: Icon(
                                                Icons.favorite_outline,
                                                color: Colors.red,
                                                size: 28,
                                              )
                                          )
                                          ;
                                        }
                                    );
                                  }
                              ),
                              right: 10,
                              top: MediaQuery.of(context).size.height * .33,
                            )
                          ]
                      ),
                    );
                  }
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
        ),
      ),
    );
  }
}