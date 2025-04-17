import 'package:flutter/material.dart';
import 'package:xnova/main_screen.dart';
import 'package:xnova/service/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String _errorMessage = '';

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final result = await _authService.register(
        _nameController.text, _emailController.text, _passwordController.text);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result['success']) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result['message'])));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        _errorMessage = result['message'];
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
                        )
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
                              SizedBox(height: 30.0),
                              Text(
                                'New here? Create an account to get started.',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan[800]),
                              ),
                              SizedBox(height: 80.0),
                              Material(
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: SizedBox(
                                    height: 45.0,
                                    width: 350.0,
                                    child: TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                          labelText: 'Name',
                                          labelStyle:
                                              TextStyle(letterSpacing: 5.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    153, 1, 101, 114),
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 1, 101, 114),
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 1, 101, 114),
                                              )),
                                          fillColor: Colors.white,
                                          filled: true),
                                    ),
                                  )),
                              const SizedBox(height: 40),
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
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    153, 1, 101, 114),
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 1, 101, 114),
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 1, 101, 114),
                                              )),
                                          fillColor: Colors.white,
                                          filled: true),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  )),
                              const SizedBox(height: 40),
                              Material(
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: SizedBox(
                                    height: 45.0,
                                    width: 350.0,
                                    child: TextField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle:
                                              TextStyle(letterSpacing: 5.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    153, 1, 101, 114),
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    153, 1, 101, 114),
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
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
                                    style: TextStyle(color: Colors.redAccent)),
                              const SizedBox(height: 60),
                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : SizedBox(
                                      width: 350.0,
                                      height: 45.0,
                                      child: ElevatedButton(
                                        onPressed: _register,
                                        style: ElevatedButton.styleFrom(
                                            elevation: 2.0,
                                            backgroundColor: Colors.cyan[800],
                                            textStyle: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        child: const Text('Register',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ))
                            ],
                          ),
                        ),
                      )),
                )
              ],
            )));
  }
}
