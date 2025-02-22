import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_model.dart';
import 'package:xnova/Model/promotion_model.dart';
// import 'package:xnova/components/home_carousel.dart';
import 'package:xnova/components/home_card_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xnova/pages/bar_detail.dart';
import 'package:xnova/pages/promos.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  List<Bar> barLists = [];
  List<Promotion> coverlists = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  bool isSearchBarVisible = false;
  bool hasMoreData = true;
  int currentPage = 1;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchBars();
    fetchCovers();

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

  Future<void> fetchCovers() async {
    final url = Uri.parse('https://xnova.nyanlinhtet.com/api/covers');

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          coverlists = data.map((json) => Promotion.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
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
          backgroundColor: Colors.white24,
          elevation: 0,
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
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: Colors.cyan, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0))),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Promotions List",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.cyan[900]),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        height: 150,
                        child: coverlists.isEmpty
                            ? Center(child: Text("No Data Available"))
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: coverlists.length + 1,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                itemBuilder: (context, index) {
                                  if (index == coverlists.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Promos(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 150,
                                        margin: EdgeInsets.only(right: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.cyan[800],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                                offset: Offset(2, 3))
                                          ],
                                        ),
                                        child: Center(
                                          child: Text("View All",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    );
                                  }
                                  final item = coverlists[index];

                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BarDetail(
                                                    barId: item.barId)));
                                      },
                                      child: Container(
                                        width: 150,
                                        margin: EdgeInsets.only(right: 12),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://xnova.nyanlinhtet.com/${item.image}'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              offset: Offset(2, 3),
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Bars List",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.cyan[900]),
                          ),
                        ),
                      ),
                      //SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: barLists.length + (isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < barLists.length) {
                            return HomeCardList([barLists[index]]);
                          } else {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )));
  }
}
