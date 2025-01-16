import 'package:flutter/material.dart';
import 'package:xnova/pages/bar_detail.dart';

final List<Map<String, dynamic>> barLists = [
  {
    'id': 1,
    'title': 'Loream Bar',
    'img': 'assets/bars/bar1.jpg',
    'opening': '10AM - 9PM',
    'happy': '5PM - 7PM'
  },
  {
    'id': 2,
    'title': 'Ipsum Bar',
    'img': 'assets/bars/bar2.jpg',
    'opening': '10AM - 9PM',
    'happy': '5PM - 7PM'
  },
  {
    'id': 3,
    'title': 'Hello Bar',
    'img': 'assets/bars/bar3.jpg',
    'opening': '10AM - 9PM',
    'happy': '5PM - 7PM'
  },
  {
    'id': 4,
    'title': 'NewYork Bar',
    'img': 'assets/bars/bar4.jpg',
    'opening': '10AM - 9PM',
    'happy': '5PM - 7PM'
  },
  {
    'id': 5,
    'title': 'Manchester Bar',
    'img': 'assets/bars/bar5.jpg',
    'opening': '10AM - 9PM',
    'happy': '5PM - 7PM'
  }
];

class HomeCardList extends StatelessWidget {
  const HomeCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Text(
            'Top Bars in Yangon',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: barLists.length,
          itemBuilder: (context, index) {
            final bar = barLists[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarDetail(bar: bar)),
                );
              },
              child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            bar['img'],
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          bar['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Opening Hour: ${bar['opening']}'),
                            Text('Happy Hour: ${bar['happy']}'),
                          ],
                        ),
                        trailing: const Icon(Icons.star),
                      )
                    ],
                  )),
            );
          },
        )
      ],
    );
  }
}
