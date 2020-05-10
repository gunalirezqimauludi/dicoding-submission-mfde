import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_app/screens/meals/dessert_screen.dart';
import 'package:flutter_app/screens/meals/seafood_screen.dart';

import './screens/detail/detail_screen.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    DessertScreen(),
    SeafoodScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meals Catalogue',
        home: Scaffold(
          backgroundColor: Color(0xfffafafa),
          appBar: AppBar(
            elevation: 0,
            title: Text('Meals Catalogue'),
            backgroundColor: Color(0xffeb4747),
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: FancyBottomNavigation(
            circleColor: Color(0xffeb4747),
            inactiveIconColor: Color(0xffeb4747),
            tabs: [
              TabData(iconData: Icons.fastfood, title: "Dessert"),
              TabData(iconData: Icons.local_dining, title: "Seafood")
            ],
            onTabChangedListener: (position) {
              setState(() {
                _currentIndex = position;
              });
            },
          ),
        ),
        routes: {
          '/home': (context) => HomeScreen(),
          '/detail': (context) => DetailScreen(),
        },
        debugShowCheckedModeBanner: false);
  }
}
