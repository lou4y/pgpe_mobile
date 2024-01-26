
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgpe_mobile/Views/settings.dart';
import '../Constant_Data/constants.dart';
import 'elimination.dart';
import 'home.dart';

class NavigationMenu extends StatefulWidget {
  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedItemIndex = 1;
  final List pages = [
    Eliminationpage(),
    HomePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar:  CurvedNavigationBar(
            backgroundColor: Colors.white,
            color:kPrimaryColor ,
            index: _selectedItemIndex,
            animationDuration: Duration(milliseconds: 200),
            items: const <Widget>[
              Icon(Icons.person_off_rounded , size: 30,color: Colors.white,),
              Icon(Icons.home, size: 30,color: Colors.white,),
              Icon(Icons.settings, size: 30,color: Colors.white,),
            ],
            onTap: (index) {
              setState(() {
                _selectedItemIndex = index;
              });//Handle button tap
            },
          ),
          body: pages[_selectedItemIndex],
        )
    );
  }
}
