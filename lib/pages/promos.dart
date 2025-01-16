import 'package:flutter/material.dart';

class Promos extends StatelessWidget {
  const Promos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/xnova_icon.png',
              height: 150,
              width: 100,
            ),
            IconButton(onPressed: () => {}, icon: Icon(Icons.search))
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: Center(
        child: Text('Hello Promos Page'),
      ),
    );
  }
}
