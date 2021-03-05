import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/provider/restaurant_provider.dart';
import 'package:restauran_app/ui/restaurant_search_page.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/Search';

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, RestaurantProvider data, widget)
      {
        return WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            data.resetSearch();
            Navigator.pop(context, true);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Search'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Consumer<RestaurantProvider>(
                          builder: (context, RestaurantProvider data, widget) {
                            return TextField(
                              onSubmitted: (value) {
                                data.searchRestaurants(value);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter a search term'
                              ),
                            );
                          }
                      )
                  ),
                  RestaurantSearchPage(),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}