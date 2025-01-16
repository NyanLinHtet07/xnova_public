import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/nearby.dart';
import 'pages/noti.dart';
import 'pages/point.dart';
import 'pages/promos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xnova',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainContext(),
    );
  }
}

class MainContext extends StatefulWidget {
  @override
  _MainContextState createState() => _MainContextState();
}

class _MainContextState extends State<MainContext> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Home(),
    Promos(),
    Point(),
    Nearby(),
    Noti()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet_giftcard), label: 'Promos'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Point'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Nearby'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Noti')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.black12,
        unselectedLabelStyle: TextStyle(color: Colors.black12),
        onTap: _onItemTapped,
      ),
    );
  }
}
