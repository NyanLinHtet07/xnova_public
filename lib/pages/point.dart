import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xnova/service/auth_service.dart';
import 'package:xnova/components/utility/no_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gal/gal.dart';
import 'dart:ui' as ui;
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:xnova/utilities/drawer.dart';

class Point extends StatefulWidget {
  const Point({super.key});

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> {
  final GlobalKey _globalKey = GlobalKey();

  final AuthService authService = AuthService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  //bool isLoading = true;
  bool isLoggedIn = false;
  String? qrCodeUrl;
  File? cachedSvgFile;

  String _userName = "";

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getUser();
  }

  void getUser() async {
    final userJson = await authService.storage.read(key: 'user');
    if (userJson != null) {
      final user = json.decode(userJson);
      if (!mounted) return;

      setState(() {
        _userName = user['name'] ?? 'Unknown User';
      });
    }
  }

  void checkLoginStatus() async {
    final loggedIn = await authService.isLoggedIn();
    if (loggedIn) {
      final userData = await storage.read(key: 'user');
      if (userData != null) {
        final user = json.decode(userData);
        final url = 'https://xnova.nyanlinhtet.com/${user['qr']}';

        final cache = await DefaultCacheManager().getFileFromCache(url);

        if (cache != null && await cache.file.exists()) {
          setState(() {
            isLoggedIn = true;
            qrCodeUrl = url;
            cachedSvgFile = cache.file;
          });
        } else {
          final file = await DefaultCacheManager().getSingleFile(url);
          setState(() {
            isLoggedIn = true;
            qrCodeUrl = url;
            cachedSvgFile = file;
          });
        }
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    }
  }

  Future<void> _saveToGallery() async {
    try {
      // Wait a tiny bit to ensure rendering is done
      await Future.delayed(const Duration(milliseconds: 300));

      final boundaryContext = _globalKey.currentContext;

      if (boundaryContext == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please wait for the widget to render')),
        );
        return;
      }

      final boundary =
          boundaryContext.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not capture widget')),
        );
        return;
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();

      if (pngBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to convert to PNG')),
        );
        return;
      }

      await Gal.putImageBytes(pngBytes, album: "Xnova");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved to gallery')),
      );
    } catch (e) {
      print("Save error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return const NoAuth();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My QR',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.cyan.shade800,
                fontSize: 24),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: _saveToGallery,
              icon: const Icon(
                Icons.save_alt,
                color: Colors.white,
              ),
              label: const Text("Save to Gallery"),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 16),
                  backgroundColor: Colors.cyan[800],
                  foregroundColor: Colors.white),
            )
          ],
        ),
        body: Center(
            child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20.0),
                          //margin: EdgeInsets.fromLTRB(5, 10.0, 5, 0),
                          height: 500,
                          width: 450,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.cyan[800]!,
                                width: 4,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/xnova_icon.png',
                              height: 110,
                              width: 110,
                              fit: BoxFit.cover,
                            ),
                            cachedSvgFile != null
                                ? SizedBox(
                                    width: 280.0,
                                    height: 280.0,
                                    child: Material(
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            child: SvgPicture.file(
                                              cachedSvgFile!,
                                              placeholderBuilder: (BuildContext
                                                      context) =>
                                                  const CircularProgressIndicator(),
                                            ),
                                          )),
                                    ))
                                : const CircularProgressIndicator(),
                            SizedBox(height: 20.0),
                            Text(_userName,
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan[800]))
                          ],
                        ),
                      ],
                    )))));
  }
}
