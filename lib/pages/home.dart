import 'package:flutter/material.dart';
import 'package:xnova/components/home_carousel.dart';
import 'package:xnova/components/home_card_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 10,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [HomeCarousel(), HomeCardList()],
          ),
        ));
  }
}
