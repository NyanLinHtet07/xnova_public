import 'package:flutter/material.dart';
import 'package:xnova/main_screen.dart';
import 'package:xnova/pages/Auth/register.dart';
import 'package:xnova/service/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authservice = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        _errorMessage = 'Login failed. Please check your email or password';
      });
    }
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
                        Image.asset(
                          'assets/xnova-white.png',
                          height: 150,
                          width: 150,
                        ),
                      ],
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.0),
                              Text(
                                'Welcome back!',
                                style: TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan[800]),
                              ),
                              SizedBox(height: 40.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                      elevation: 2.0,
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: SizedBox(
                                        height: 45.0,
                                        width: 350.0,
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle:
                                                  TextStyle(letterSpacing: 5.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: const Color.fromARGB(
                                                        153, 1, 101, 114),
                                                  )),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 1, 101, 114),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: const Color.fromARGB(
                                                        255, 1, 101, 114),
                                                  )),
                                              fillColor: Colors.white,
                                              filled: true),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      )),
                                  const SizedBox(height: 40),
                                  Material(
                                      elevation: 2.0,
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: SizedBox(
                                        height: 45.0,
                                        width: 350,
                                        child: TextField(
                                          controller: _passwordController,
                                          obscureText: _obscurePassword,
                                          decoration: InputDecoration(
                                              labelText: 'Password',
                                              labelStyle:
                                                  TextStyle(letterSpacing: 5.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: const Color.fromARGB(
                                                        153, 1, 101, 114),
                                                  )),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: const Color.fromARGB(
                                                        153, 1, 101, 114),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: const Color.fromARGB(
                                                        153, 1, 101, 114),
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
                                                      _obscurePassword =
                                                          !_obscurePassword;
                                                    });
                                                  })),
                                        ),
                                      )),
                                  const SizedBox(height: 10),
                                  if (_errorMessage.isNotEmpty)
                                    Text(_errorMessage,
                                        style: TextStyle(color: Colors.red)),
                                  const SizedBox(height: 60),
                                  _isLoading
                                      ? const CircularProgressIndicator()
                                      : SizedBox(
                                          width: 350.0,
                                          height: 45.0,
                                          child: ElevatedButton(
                                            onPressed: _login,
                                            style: ElevatedButton.styleFrom(
                                                elevation: 2.0,
                                                backgroundColor:
                                                    Colors.cyan[800],
                                                textStyle: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            child: const Text('Login',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                  const SizedBox(height: 5),
                                  Text('or',
                                      style: TextStyle(
                                          color: Colors.cyan[800],
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 350.0,
                                    height: 45.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 2.0,
                                          backgroundColor: Colors.cyan[800],
                                          textStyle: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                      child: const Text('Register Here',
                                          style:
                                              TextStyle(color: Colors.white)),
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
            )));
  }
}
