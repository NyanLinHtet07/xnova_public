import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imagePaths = [
  'assets/home/img1.jpg',
  'assets/home/img2.jpg',
  'assets/home/img3.jpg',
  'assets/home/img4.jpg',
  'assets/home/img5.jpg',
];

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CarouselSlider(
          items: imagePaths.map((img) {
            return Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(img),
                    fit: BoxFit.cover,
                  )),
            );
          }).toList(),
          options: CarouselOptions(
            height: 100.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          )),
    );
  }
}
