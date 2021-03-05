import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app/common/styles.dart';
import 'package:restauran_app/model/restauran.dart';
import 'package:restauran_app/provider/preferences_provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final Function onPressed;

  const CardRestaurant({Key key, @required this.restaurant, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return Material(
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              leading: restaurant.pictureId == null ?
              Container(width: 100, child: Icon(Icons.error))
                  :
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/"+restaurant.pictureId,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(restaurant.name ?? ""),
              subtitle: restaurant.city == null || restaurant.rating == null ?
              ""
                  :
              Column(
                children: [
                  SizedBox(height: 5,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined,size: 13,color: provider.isDarkTheme ? darkSecondaryColor: secondaryColor,),
                          Text(restaurant.city),
                        ],
                      )
                  ),
                  SizedBox(height: 3,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.grade_outlined,size: 13,color: provider.isDarkTheme ? darkSecondaryColor: secondaryColor,),
                          Text(restaurant.rating.toString()),
                        ],
                      )
                  ),
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: onPressed,
            ),
          );
        }
    );
  }
}