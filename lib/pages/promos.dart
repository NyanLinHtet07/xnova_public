import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xnova/Model/promotion_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xnova/pages/bar_detail.dart';

class Promos extends StatefulWidget {
  const Promos({super.key});

  @override
  State<Promos> createState() => _Promos();
}

class _Promos extends State<Promos> {
  List<Promotion> promoList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPromos();
  }

  Future<void> fetchPromos() async {
    final url = Uri.parse('https://xnova.nyanlinhtet.com/api/bar/promo');

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          promoList = data.map((json) => Promotion.fromJson(json)).toList();
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
    await fetchPromos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Xnova"),
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
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Promotion List",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.cyan[900]),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: promoList.length,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            final item = promoList[index];

                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BarDetail(barId: item.barId),
                                      ));
                                },
                                child: Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 15),
                                  color:
                                      const Color.fromARGB(255, 247, 252, 255),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0)),
                                        child: item.image != null &&
                                                item.image!.isNotEmpty
                                            ? Image.network(
                                                'https://xnova.nyanlinhtet.com/${item.image}',
                                                height: 195.0,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              )
                                            : Stack(
                                                children: [
                                                  Opacity(
                                                    opacity: 0.1,
                                                    child: Image.asset(
                                                      'assets/xnova_cover.png',
                                                      height: 195.0,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          item.bar.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Before : ${item.endDate}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // Text('Happy Hour: N/A'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          }),
                    ],
                  ),
                ),
              ));
  }
}
