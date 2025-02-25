import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:xnova/Model/bar_detail_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BarDetailIndex extends StatefulWidget {
  final BarDetailData barDetail;

  const BarDetailIndex(this.barDetail, {super.key});

  @override
  State<BarDetailIndex> createState() => _BarDetailIndexState();
}

class _BarDetailIndexState extends State<BarDetailIndex> {
  void _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $phoneNumber');
    }
  }

  void _makeMessage(String phoneNumber) async {
    Uri uri = Uri.parse("sms:$phoneNumber?body=''");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch';
    }
  }

  void openMaps() async {
    final availableMaps = await MapLauncher.installedMaps;

    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showMarker(
        coords:
            Coords(widget.barDetail.lat ?? 0.0, widget.barDetail.lng ?? 0.0),
        title: "Destination",
      );
    } else {
      throw 'No available map';
    }
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.cyan[800],
    backgroundColor: Colors.cyan[800],
    iconColor: Colors.white,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.barDetail.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 20, color: Color.fromARGB(255, 0, 108, 122)),
              const SizedBox(width: 20),
              SizedBox(
                  width: 330.0,
                  child: Text(
                    widget.barDetail.address ?? "Soon",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.phone,
                  size: 20, color: Color.fromARGB(255, 0, 108, 122)),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  if (widget.barDetail.contact != null &&
                      widget.barDetail.contact!.isNotEmpty) {
                    _makePhoneCall(widget.barDetail.contact!);
                  }
                },
                child: Text(
                  widget.barDetail.contact ?? 'No contact available',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.sms_rounded,
                  size: 20, color: Color.fromARGB(255, 0, 108, 122)),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  if (widget.barDetail.contact != null &&
                      widget.barDetail.contact!.isNotEmpty) {
                    _makeMessage(widget.barDetail.contact!);
                  }
                },
                child: Text(
                  widget.barDetail.contact ?? 'No contact available',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.browse_gallery_outlined,
                  size: 20, color: Color.fromARGB(255, 0, 108, 122)),
              const SizedBox(width: 20),
              Text(
                widget.barDetail.openingTime,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(height: 30),
          // ElevatedButton(
          //     onPressed: () {
          //       if (widget.barDetail.lat != null &&
          //           widget.barDetail.lng != null) {
          //         openMaps(widget.barDetail.lat!, widget.barDetail.lng!);
          //       } else {
          //         debugPrint('Latitude or Longitude is null');
          //       }
          //     },
          //     child: Text('Go to Map')),
          SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton.icon(
              onPressed: () {
                openMaps(); // Example: Dubai coordinates
              },
              style: raisedButtonStyle,
              icon: Icon(Icons.location_pin),
              label: Text(
                "Open in Map",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            'Gallery',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          widget.barDetail.images.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
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
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amenities',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (widget.barDetail.amenities.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Wrap(
                      spacing: 8,
                      children: widget.barDetail.amenities.map((amenity) {
                        return Chip(
                          label: Text(amenity.name),
                          backgroundColor: Colors.white,
                        );
                      }).toList(),
                    ),
                  ),
                const SizedBox(height: 8.0)
              ],
            ),
          )
        ],
      ),
    ));
  }
}
