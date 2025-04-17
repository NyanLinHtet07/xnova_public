import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xnova/service/auth_service.dart';
import 'package:xnova/components/utility/no_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:xnova/utilities/drawer.dart';

class Point extends StatefulWidget {
  const Point({super.key});

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> {
  final AuthService authService = AuthService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  //bool isLoading = true;
  bool isLoggedIn = false;
  String? qrCodeUrl;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final loggedIn = await authService.isLoggedIn();
    if (loggedIn) {
      final userData = await storage.read(key: 'user');
      if (userData != null) {
        final user = json.decode(userData);
        setState(() {
          isLoggedIn = true;
          qrCodeUrl = 'https://xnova.nyanlinhtet.com/${user['qr']}';
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return const NoAuth();
    }

    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/xnova_icon.png',
                        height: 160,
                        width: 160,
                      ),
                      const SizedBox(height: 10),
                      qrCodeUrl != null
                          ? Material(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    child: SvgPicture.network(
                                      qrCodeUrl!,
                                      placeholderBuilder:
                                          (BuildContext context) =>
                                              const CircularProgressIndicator(),
                                    ),
                                  )),
                            )
                          : const CircularProgressIndicator()
                    ],
                  ),
                ))));
  }
}
