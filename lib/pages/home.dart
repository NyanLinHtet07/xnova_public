import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_model.dart';
import 'package:xnova/components/home_carousel.dart';
import 'package:xnova/components/home_card_list.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  List<Bar> barLists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBars();
  }

  Future<void> fetchBars() async {
    final url = Uri.parse('https://xnova.nyanlinhtet.com/api/bars');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> fetchBars = responseData['data'];

        setState(() {
          barLists = fetchBars.map((json) => Bar.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshBars() async {
    setState(() {
      isLoading = true;
    });
    await fetchBars();
  }

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
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 10,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: refreshBars,
                child: SingleChildScrollView(
                  child: Column(
                    children: [const HomeCarousel(), HomeCardList(barLists)],
                  ),
                )));
  }
}
