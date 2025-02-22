import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:xnova/components/home_detail/bar_detail_comment.dart';
import 'package:xnova/components/home_detail/bar_detail_index.dart';
//import 'package:xnova/components/home_detail/bar_detail_menu.dart';
import 'package:xnova/components/home_detail/bar_detail_menu_new.dart';
//import 'package:xnova/components/home_detail/bar_detail_map.dart';

import 'package:xnova/components/home_detail/bar_detail_point.dart';
import 'package:xnova/components/home_detail/bar_detail_promo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class BarDetail extends StatefulWidget {
  final int barId;

  const BarDetail({super.key, required this.barId});

  @override
  State<BarDetail> createState() => _BarDetailState();
}

class _BarDetailState extends State<BarDetail> {
  BarDetailData? barDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBarDetail();
  }

  Future<void> fetchBarDetail() async {
    final url =
        Uri.parse('https://xnova.nyanlinhtet.com/api/bars/${widget.barId}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          barDetail = BarDetailData.fromJson(data);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load bar details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: SpinKitWaveSpinner(
                  color: Colors.cyan,
                  size: 80,
                  duration: Duration(milliseconds: 3000),
                ),
              )
            : barDetail == null
                ? const Center(child: Text('No Data Available'))
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        title: Text(
                          barDetail?.name ?? 'Loading ...',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        // backgroundColor: Colors.white,
                        // foregroundColor: Colors.white,
                        iconTheme: const IconThemeData(
                            color: Colors.white, size: 24.0),
                        pinned: true,
                        floating: true,
                        expandedHeight: 300.0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: barDetail!.cover != null
                              ? Image.network(
                                  'https://xnova.nyanlinhtet.com/${barDetail!.cover!}',
                                  height: 300.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Stack(
                                  children: [
                                    Opacity(
                                      opacity: 0.2,
                                      child: Image.asset(
                                        'assets/xnova_cover.png',
                                        height: 300.0,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: Text(
                                          barDetail!.name,
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              color: Color.fromARGB(
                                                  255, 0, 12, 44),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(74.0),
                            child: Container(
                              //margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(236, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                                child: Material(
                                  elevation: 12,
                                  //shadowColor: Colors.cyan,
                                  color:
                                      const Color.fromARGB(236, 255, 255, 255),
                                  child: const TabBar(
                                    labelColor:
                                        Color.fromARGB(255, 9, 123, 138),
                                    unselectedLabelColor:
                                        Color.fromARGB(255, 29, 66, 69),
                                    indicatorColor:
                                        Color.fromARGB(255, 9, 123, 138),
                                    isScrollable: false,
                                    tabs: [
                                      Tab(
                                          text: 'Info',
                                          icon: Icon(FeatherIcons.home)),
                                      Tab(
                                          text: 'Menu',
                                          icon: Icon(Icons.restaurant_sharp)),
                                      Tab(
                                          text: 'Point',
                                          icon: Icon(Icons.qr_code_scanner)),
                                      Tab(
                                          text: 'Review',
                                          icon:
                                              Icon(FeatherIcons.messageCircle)),
                                      Tab(
                                          text: 'Promos',
                                          icon: Icon(Icons.wallet_giftcard)),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                    body: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TabBarView(
                        physics:
                            const AlwaysScrollableScrollPhysics(), // Allow scrolling
                        children: [
                          BarDetailIndex(barDetail!),
                          BarDetailMenuNew(barId: barDetail!.id),
                          BarDetailPoint(barDetail!),
                          BarDetailComment(barDetail!),
                          BarDetailPromos(barId: barDetail!.id),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
