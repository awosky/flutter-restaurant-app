import 'package:flutter/material.dart';
import 'package:restauran_app/ui/restaurant_detail_page.dart';
import 'package:restauran_app/ui/restaurant_list_page.dart';
import 'package:restauran_app/ui/search_page.dart';
import 'package:restauran_app/ui/settings_page.dart';
import 'package:restauran_app/utils/background_service.dart';
import 'package:restauran_app/utils/notification_helper.dart';

import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  int _bottomNavIndex = 0;
  static const String _homeText = 'Home';

  List<Widget> _headerItems = [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Restaurant'),
        Text(
          'Recommendation restaurant for you',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4
          ),
        ),
      ],
    ),
    Text(FavoritesPage.favoritesTitle),
    Text(SettingsPage.SettingsTitle)
  ];

  List<Widget> _listWidget = [
    RestaurantListPage(),
    FavoritesPage(),
    SettingsPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.public),
      title: Text(_homeText),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      title: Text(FavoritesPage.favoritesTitle),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text(SettingsPage.SettingsTitle),
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailPage.routeName);
  }
  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _headerItems[_bottomNavIndex],
            _bottomNavIndex == 0 ? IconButton(icon: Icon(Icons.search), onPressed: () {Navigator.pushNamed(context,SearchPage.routeName,);}) : SizedBox()
          ],
        ),
      ),
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}

