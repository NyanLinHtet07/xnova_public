import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'pages/home.dart';
//import 'pages/nearby.dart';
import 'pages/noti.dart';
import 'pages/point.dart';
import 'pages/promos.dart';
import 'pages/calender.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Home(),
    Promos(),
    Point(),
    Calender(),
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
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomAppBar(
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              notchMargin: 10.0,
              height: 60,
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(FeatherIcons.home, 'Home', 0),
                    _buildNavItem(Icons.wallet_giftcard, 'Promos', 1),
                    const SizedBox(width: 60),
                    _buildNavItem(FeatherIcons.calendar, 'Calender', 3),
                    _buildNavItem(FeatherIcons.messageCircle, 'Noti', 4)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: FloatingActionButton(
                backgroundColor: Colors.cyan[800],
                elevation: 6.0,
                shape: const CircleBorder(),
                onPressed: () => _onItemTapped(2),
                child: const Icon(Icons.qr_code_scanner,
                    size: 30, color: Colors.white),
              ),
            )
          ],
        ));
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:
                _selectedIndex == index ? Colors.cyan[800] : Colors.grey[600],
            size: 18.0,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              color:
                  _selectedIndex == index ? Colors.cyan[800] : Colors.grey[600],
            ),
          )
        ],
      ),
    );
  }
}
