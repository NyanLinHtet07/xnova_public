import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_detail_model.dart';

class BarDetailPoint extends StatefulWidget {
  final BarDetailData barDetail;

  const BarDetailPoint(this.barDetail, {super.key});

  @override
  _BarDetailPoint createState() => _BarDetailPoint();
}

class _BarDetailPoint extends State<BarDetailPoint> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.card_giftcard_outlined),
              const SizedBox(width: 10),
              Text(
                'Total Points - 1000',
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Image(image: AssetImage('assets/barcode.png')),
        ],
      ),
    );
  }
}
