import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class BarDetail extends StatelessWidget {
  final Map<String, dynamic> bar;

  const BarDetail({super.key, required this.bar});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(bar['title']),
          backgroundColor: Colors.white.withOpacity(0.5),
        ),
        body: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: Image.asset(
                bar['img'],
                height: 250.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'Detail', icon: Icon(Icons.info_outline)),
                Tab(text: 'Rewards', icon: Icon(Icons.card_giftcard)),
                Tab(text: 'Map', icon: Icon(Icons.map)),
                Tab(text: 'Comment', icon: Icon(Icons.comment)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDetailTab(),
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
    final List<Map<String, String>> menuItems = [
      {'name': 'Cocktail', 'price': '\$12'},
      {'name': 'Beer', 'price': '\$8'},
      {'name': 'Wine', 'price': '\$15'},
      {'name': 'Whiskey', 'price': '\$20'},
      {'name': 'Snacks', 'price': '\$5'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bar['title'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Opening Hour: ${bar['opening']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Happy Hour: ${bar['happy']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            'Menu',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.wine_bar, color: Colors.black),
                          const SizedBox(width: 10),
                          Text(
                            item['name']!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        item['price']!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
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
    final LatLng location = LatLng(16.83449908173125, 96.17730645986191);

    return FlutterMap(
      options: MapOptions(initialCenter: location, initialZoom: 9.2),
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
