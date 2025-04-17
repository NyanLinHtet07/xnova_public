import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xnova/Model/bar_detail_model.dart';
import 'package:xnova/service/auth_service.dart';
import 'package:xnova/components/utility/no_auth_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BarDetailPoint extends StatefulWidget {
  final BarDetailData barDetail;

  const BarDetailPoint(this.barDetail, {super.key});

  @override
  State<BarDetailPoint> createState() => _BarDetailPoint();
}

class _BarDetailPoint extends State<BarDetailPoint> {
  final AuthService authService = AuthService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

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
      return const NoAuthDetail();
    }

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 60),
          qrCodeUrl != null
              ? Material(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: SvgPicture.network(
                            qrCodeUrl!,
                            placeholderBuilder: (BuildContext context) =>
                                const CircularProgressIndicator(),
                          ))))
              : const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.card_giftcard_outlined),
              const SizedBox(width: 10),
              Text(
                'Total Points - 1000',
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
