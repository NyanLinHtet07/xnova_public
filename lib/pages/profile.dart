import 'package:flutter/material.dart';
import 'package:xnova/main_screen.dart';
import 'package:xnova/service/auth_service.dart';
import 'dart:convert';

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
      });
    }
  }

  void _logout() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

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
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 4))
                          ]),
                      child: Image.asset(
                        'assets/avt1.png',
                        height: 100,
                        width: 100,
                      ))
                  // Image.asset(
                  //   'assets/avt1.png',
                  //   height: 150,
                  //   width: 150,
                  // )
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                    fontSize: 18, fontWeight: FontWeight.w500),
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
                                    fontSize: 18, fontWeight: FontWeight.w500),
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
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            )),
                        SizedBox(height: 10),
                        Divider(),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 350.0,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _logout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red[800],
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
