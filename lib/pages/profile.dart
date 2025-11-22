import 'package:flutter/material.dart';
import 'package:xnova/main_screen.dart';
import 'package:xnova/service/auth_service.dart';
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String _errorMessage = '';

  String _userName = '';
  String _userEmail = '';
  String _userPhone = '';
  String _userProfile = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final userJson = await _authService.storage.read(key: 'user');

    if (userJson != null) {
      final user = json.decode(userJson);
      if (!mounted) return;

      setState(() {
        _userName = user['name'] ?? 'Unknown User';
        _userEmail = user['email'] ?? 'No Email';
        _userPhone = user['phone'] ?? 'No Phone Number';
        _userProfile = user['profile'] ?? '';
      });
    }
  }

  void _logout() async {
    final userJson = await _authService.storage.read(key: 'user');

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    if (userJson != null) {
      final user = json.decode(userJson);
      final qrUrl = 'https://xnova.nyanlinhtet.com/${user['qr']}';

      await DefaultCacheManager().removeFile(qrUrl);
    }

    await _authService.logout();

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.cyan[800],
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: _userProfile.isNotEmpty
                          ? NetworkImage(
                              'https://xnova.nyanlinhtet.com/${_userProfile}')
                          : null,
                      child: _userProfile.isNotEmpty
                          ? Text(
                              _userName[0],
                              style: const TextStyle(fontSize: 16),
                            )
                          : null,
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 5,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32),
                      )),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (_isLoading) const CircularProgressIndicator(),
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _errorMessage,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            const SizedBox(height: 20),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                                  child: Text(
                                    'Name: $_userName',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                                  child: Text(
                                    'Email: $_userEmail',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                                  child: Text(
                                    'Phone: $_userPhone',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                                  child: Text(
                                    'Point List',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                                  child: Text(
                                    'Setting',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            SizedBox(height: 10),
                            Divider(),
                            const SizedBox(height: 10),
                          ],
                        ),
                        SizedBox(
                          width: 350.0,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _logout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[800],
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    ));
  }
}
