import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_model.dart';
import 'package:xnova/components/home_carousel.dart';
import 'package:xnova/components/home_card_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool isSearchBarVisible = false;

  TextEditingController _searchController = TextEditingController();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                      visible: isSearchBarVisible == false,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.cyan[800],
                        iconSize: 28.0,
                        onPressed: () {
                          setState(() {
                            isSearchBarVisible = true;
                          });
                        },
                      )),
                  IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.menu),
                    iconSize: 28.0,
                    color: Colors.cyan[800],
                  )
                ],
              )
            ],
          ),
          backgroundColor: Colors.white60,
          elevation: 10,
        ),
        body: isLoading
            ? const Center(
                child: SpinKitWaveSpinner(
                  color: Colors.cyan,
                  size: 80,
                  duration: Duration(milliseconds: 3000),
                ),
              )
            : RefreshIndicator(
                onRefresh: refreshBars,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Visibility(
                        visible: isSearchBarVisible,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                                hintText: 'Search ...',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      isSearchBarVisible = false;
                                      _searchController.clear();
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: Colors.cyan, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0))),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      const HomeCarousel(),
                      HomeCardList(barLists)
                    ],
                  ),
                )));
  }
}
