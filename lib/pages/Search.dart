import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _Search();
}

class _Search extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
      child: Text('Hello Search'),
    ));
  }
}
