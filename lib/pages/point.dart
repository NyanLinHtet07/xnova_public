import 'package:flutter/material.dart';
import 'package:xnova/service/auth_service.dart';
import 'package:xnova/components/utility/no_auth.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:xnova/utilities/drawer.dart';

class Point extends StatefulWidget {
  const Point({super.key});

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> {
  final AuthService authService = AuthService();
  //bool isLoading = true;
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

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return const NoAuth();
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/xnova_icon.png',
              height: 80,
              width: 80,
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Image(image: AssetImage('assets/qr.jpg')),
              ))),
    );
  }
}
