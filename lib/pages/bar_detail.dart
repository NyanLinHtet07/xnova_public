import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:xnova/Model/bar_detail_model.dart';
import 'package:http/http.dart' as http;

class BarDetail extends StatefulWidget {
  final int barId;

  const BarDetail({super.key, required this.barId});

  @override
  _BarDetailState createState() => _BarDetailState();
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

      print('Error fetch bar details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(barDetail?.name ?? 'Loading ...'),
          backgroundColor: Colors.white,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : barDetail == null
                ? const Center(child: Text('No Data Available'))
                : Column(
                    children: [
                      barDetail!.cover != null
                          ? Image.network(
                              'https://xnova.nyanlinhtet.com/${barDetail!.cover!}',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Stack(
                              children: [
                                Opacity(
                                  opacity: 0.2,
                                  child: Image.asset(
                                    'assets/xnova_cover.png',
                                    height: 200,
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
                                        color: Color.fromARGB(255, 0, 12, 44),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                              ],
                            ),
                      const TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.blue,
                        tabs: [
                          Tab(text: 'Detail', icon: Icon(Icons.info_outline)),
                          Tab(text: 'Menu', icon: Icon(Icons.menu)),
                          Tab(text: 'Rewards', icon: Icon(Icons.card_giftcard)),
                          Tab(text: 'Map', icon: Icon(Icons.map)),
                          Tab(text: 'Comment', icon: Icon(Icons.comment)),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildDetailTab(),
                            _buildMenuTab(),
                            _buildRewardsTab(),
                            _buildMapTab(),
                            _buildCommentTab(),
                          ],
                        ),
                      )
                    ],
                  ),
      ),
    );
  }

  Widget _buildDetailTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            barDetail!.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Address: ${barDetail!.address}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Opening Hour: ${barDetail!.openingTime}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Happy Hour: N/A',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            'Gallery',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          barDetail!.images.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: barDetail!.images.length,
                  itemBuilder: (context, index) {
                    final image = barDetail!.images[index];
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: InteractiveViewer(
                                    panEnabled: true,
                                    minScale: 0.5,
                                    maxScale: 3.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        'https://xnova.nyanlinhtet.com/${image.image}',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            'https://xnova.nyanlinhtet.com/${image.image}',
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ));
                  },
                )
              : const Center(child: Text('Gallery will Soon')),
        ],
      ),
    );
  }

  Widget _buildMenuTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   'Menu',
        //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: barDetail!.menus.length,
            itemBuilder: (context, index) {
              final category = barDetail!.menus[index];
              return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: category.menus.length,
                        itemBuilder: (context, itemIndex) {
                          final item = category.menus[itemIndex];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.wine_bar,
                                        color: Colors.black),
                                    const SizedBox(width: 10),
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${item.price} MMK',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black45),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ));
            },
          ),
        )
      ],
    );
  }

  Widget _buildRewardsTab() {
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

  Widget _buildMapTab() {
    final LatLng location =
        LatLng(barDetail!.lat ?? 0.0, barDetail!.lng ?? 0.0);

    return FlutterMap(
      options: MapOptions(initialCenter: location, initialZoom: 16.2),
      children: [
        TileLayer(
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
          userAgentPackageName: 'com.example.xnova',
        ),
        MarkerLayer(
          markers: [
            Marker(
                point: location,
                child: Builder(
                  builder: (ctx) => const Icon(
                    Icons.location_pin,
                    color: Colors.cyan,
                    size: 40.0,
                  ),
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentTab() {
    final List<Map<String, dynamic>> commentList = [
      {
        'id': 1,
        'comment':
            "Great atmosphere and friendly staff—perfect spot for a night out"
      },
      {
        'id': 2,
        'comment':
            "ဒီဘားမှာ အရသာရှိတဲ့ ကော်တေ့လ်တွေကို အတူတကွ ရင်းနှီးပြီး ခံစားနိုင်ပါတယ်။"
      },
      {
        'id': 3,
        'comment':
            "I love the vibe of this bar—chill, but with enough energy to keep things fun"
      },
    ];

    final TextEditingController _commentController = TextEditingController();

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: commentList.length,
                itemBuilder: (context, index) {
                  final item = commentList[index];
                  return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 350,
                            ),
                            child: Text(item['comment'],
                                style: const TextStyle(fontSize: 12)),
                          )
                        ],
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment ...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ));
  }
}
