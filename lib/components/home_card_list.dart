import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_model.dart';
import 'package:xnova/pages/bar_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeCardList extends StatefulWidget {
  const HomeCardList({super.key});

  @override
  _HomeCardListState createState() => _HomeCardListState();
}

class _HomeCardListState extends State<HomeCardList> {
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
          barLists = fetchBars.map((json) => Bar.fromJson(json)).toList(); //
          isLoading = false;
        });

        // print('Fetched Bars: ${barLists}');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching bars: $e');
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: refreshBars,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'Top Bars in Yangon',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                barLists.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('No Data Available'),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: barLists.length,
                        itemBuilder: (context, index) {
                          final bar = barLists[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BarDetail(barId: bar.id),
                                  ));
                            },
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: bar.cover != null &&
                                              bar.cover!.isNotEmpty
                                          ? Image.network(
                                              'https://xnova.nyanlinhtet.com/${bar.cover!}', // Use the original if already complete
                                              height: 240.0,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              width: double.infinity,
                                              height: 240.0,
                                              color: const Color.fromARGB(
                                                  255, 128, 192, 201),
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  bar.name,
                                                  style: const TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      bar.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Opening Hour : ${bar.openingTime}',
                                        ),
                                        Text('Happy Hour: N/A'),
                                      ],
                                    ),
                                    trailing: const Icon(Icons.favorite),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
              ],
            ),
          );
  }
}
