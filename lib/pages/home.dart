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
  bool isLoadingMore = false;
  bool isSearchBarVisible = false;
  bool hasMoreData = true;
  int currentPage = 1;

  TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchBars();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMoreBars();
      }
    });
  }

  Future<void> fetchBars({String search = ''}) async {
    setState(() {
      currentPage = 1;
      hasMoreData = true;
      //isLoading = true;
    });

    final url =
        Uri.parse('https://xnova.nyanlinhtet.com/api/bars?search=$search');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> fetchBars = responseData['data'];

        setState(() {
          barLists = fetchBars.map((json) => Bar.fromJson(json)).toList();
          isLoading = false;
        });

        if (fetchBars.isEmpty) {
          hasMoreData = false;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchMoreBars() async {
    if (!hasMoreData || isLoadingMore) return;

    setState(() {
      isLoadingMore = true;
    });

    currentPage++; // **Increment the page before making the request**
    final url = Uri.parse(
        'https://xnova.nyanlinhtet.com/api/bars?page=$currentPage&search=${_searchController.text}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> fetchBars = responseData['data'];

        setState(() {
          barLists.addAll(fetchBars.map((json) => Bar.fromJson(json)).toList());
          isLoadingMore = false;
        });

        if (fetchBars.isEmpty) {
          hasMoreData = false;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> refreshBars() async {
    await fetchBars(search: _searchController.text);
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
                      visible: !isSearchBarVisible,
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
                child: Column(
                  children: [
                    Visibility(
                      visible: isSearchBarVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            fetchBars(search: value);
                          },
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
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 1.0),
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
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: barLists.length + (isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < barLists.length) {
                            return HomeCardList([barLists[index]]);
                          } else {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }
}
