import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_model.dart';
import 'package:xnova/pages/bar_detail.dart';

class HomeCardList extends StatefulWidget {
  final List<Bar> barLists;

  const HomeCardList(this.barLists, {super.key});

  @override
  State<HomeCardList> createState() => _HomeCardListState();
}

class _HomeCardListState extends State<HomeCardList> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      widget.barLists.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('No Data Available'),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.barLists.length,
              itemBuilder: (context, index) {
                final bar = widget.barLists[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarDetail(barId: bar.id),
                        ));
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    color: const Color.fromARGB(255, 247, 252, 255),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            child: bar.cover != null && bar.cover!.isNotEmpty
                                ? Image.network(
                                    'https://xnova.nyanlinhtet.com/${bar.cover!}', // Use the original if already complete
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
                                      Positioned.fill(
                                          child: Center(
                                        child: Text(
                                          bar.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 24.0,
                                              color: Color.fromARGB(
                                                  255, 0, 12, 44),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))
                                    ],
                                  ),
                          ),
                        ),
                        ListTile(
                            title: Text(
                              bar.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Opening : ${bar.openingTime}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                // Text('Happy Hour: N/A'),
                              ],
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(5, (starIndex) {
                                  final starRating = bar.rating;
                                  if (starRating >= starIndex + 1) {
                                    return const Icon(Icons.star,
                                        color: Colors.amber, size: 18);
                                  } else if (starRating > starIndex &&
                                      starRating < starIndex + 1) {
                                    return const Icon(Icons.star_half,
                                        color: Colors.amber, size: 18);
                                  } else {
                                    return Icon(Icons.star,
                                        color: Colors.grey[300], size: 18);
                                  }
                                })))
                      ],
                    ),
                  ),
                );
              },
            )
    ]);
  }
}
