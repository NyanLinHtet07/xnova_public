import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
import 'package:xnova/pages/Auth/login.dart';

class NoAuthDetail extends StatelessWidget {
  const NoAuthDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/xnova_icon.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 10),
              // Lottie.asset(
              //   'assets/gif/no_auth.json',
              // ),
              // const SizedBox(height: 10),
              const Text(
                'Please login to view your datas.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 82, 92)),
              ),
              const SizedBox(height: 15),
              SizedBox(
                  width: 200.0,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.cyan[800],
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      child: Text('Login')))
            ],
          ),
        ),
      ),
    );
  }
}
