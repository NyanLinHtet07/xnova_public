import 'package:flutter/material.dart';
import 'package:xnova/main_screen.dart';
import 'package:xnova/pages/home.dart';
import 'package:xnova/service/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authservice = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _errorMessage = '';

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final success = await _authservice.login(
      _emailController.text,
      _passwwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } else {
      setState(() {
        _errorMessage = 'Login failed. Please check your email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/xnova_icon.png',
                  height: 150,
                  width: 150,
                ),
              ],
            )),
        Expanded(
          flex: 5,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(244, 0, 131, 143),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(20.0),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 1, 101, 114),
                                      )),
                                  fillColor: Colors.white,
                                  filled: true),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 50),
                          Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(20.0),
                            child: TextField(
                              controller: _passwwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 1, 101, 114),
                                      )),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      })),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (_errorMessage.isNotEmpty)
                            Text(_errorMessage,
                                style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 60),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: 150.0,
                                  height: 45.0,
                                  child: ElevatedButton(
                                    onPressed: _login,
                                    style: ElevatedButton.styleFrom(
                                        elevation: 2.0,
                                        backgroundColor: Colors.white,
                                        textStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    child: const Text('Login',
                                        style:
                                            TextStyle(color: Colors.black87)),
                                  ),
                                ),
                          const SizedBox(height: 5),
                          Text('or', style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 150.0,
                            height: 45.0,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  elevation: 2.0,
                                  backgroundColor: Colors.white,
                                  textStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              child: const Text('Register Here',
                                  style: TextStyle(color: Colors.black87)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    ));
  }
}
