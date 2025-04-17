import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:xnova/service/auth_service.dart';
//import 'package:xnova/components/utility/no_auth.dart';
import 'pages/home.dart';
import 'pages/noti.dart';
import 'pages/point.dart';
import 'pages/promos.dart';
import 'pages/profile.dart';
import 'pages/Auth/login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final AuthService authService = AuthService();

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final loggedIn = await authService.isLoggedIn();
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  List<Widget> get _pages => [
        Home(),
        Promos(),
        Point(),
        Noti(),
        if (!isLoggedIn) Login(),
        Profile(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            _pages.length > _selectedIndex ? _pages[_selectedIndex] : _pages[0],
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
                    _buildNavItem(FeatherIcons.messageCircle, 'Noti', 3),
                    _buildNavItem(
                        FeatherIcons.user, isLoggedIn ? 'Profile' : 'Login', 4),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: MediaQuery.of(context).size.width / 2 - 28,
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
