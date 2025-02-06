import 'package:flutter/material.dart';

class Noti extends StatelessWidget {
  const Noti({super.key});

  @override
  Widget build(BuildContext context) {
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
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.menu),
              iconSize: 28.0,
              color: Colors.cyan[800],
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: Center(
        child: Text('Hello Notifications'),
      ),
    );
  }
}
