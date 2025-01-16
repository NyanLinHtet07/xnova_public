import 'package:flutter/material.dart';

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
      child: Text('Rewards Tab of ${bar['title']}'),
    );
  }

  Widget _buildMapTab() {
    return Center(
      child: Text('Map of ${bar['title']}'),
    );
  }

  Widget _buildCommentTab() {
    return Center(
      child: Text('Comment of ${bar['title']}'),
    );
  }
}
