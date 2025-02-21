import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_detail_model.dart';

class BarDetailIndex extends StatefulWidget {
  final BarDetailData barDetail;

  const BarDetailIndex(this.barDetail, {super.key});

  @override
  _BarDetailIndexState createState() => _BarDetailIndexState();
}

class _BarDetailIndexState extends State<BarDetailIndex> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.barDetail.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Phone: ${widget.barDetail.contact}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Address: ${widget.barDetail.address}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Opening Hour: ${widget.barDetail.openingTime}',
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
          widget.barDetail.images.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: widget.barDetail.images.length,
                  itemBuilder: (context, index) {
                    final image = widget.barDetail.images[index];
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
}
