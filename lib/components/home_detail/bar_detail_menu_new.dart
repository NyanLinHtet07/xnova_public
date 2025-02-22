import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xnova/Model/bar_menu_model.dart';

class BarDetailMenuNew extends StatefulWidget {
  final int barId;

  const BarDetailMenuNew({super.key, required this.barId});

  @override
  State<BarDetailMenuNew> createState() => _BarDetailMenuNew();
}

class _BarDetailMenuNew extends State<BarDetailMenuNew> {
  List<BarMenuModel> menuList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchMenus();
  }

  Future<void> fetchMenus() async {
    final url = Uri.parse(
        'https://xnova.nyanlinhtet.com/api/bar/menu/by-bar/${widget.barId}');

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print("menu list is ${data}");
        setState(() {
          menuList = data.map((json) => BarMenuModel.fromJson(json)).toList();
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: SpinKitWaveSpinner(
              color: Colors.cyan,
              size: 80,
              duration: Duration(milliseconds: 3000),
            ),
          )
        : SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                final item = menuList[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Text(
                          item.title,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 4, 66, 74)),
                        )),
                    item.menuItems.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: item.menuItems.length,
                            itemBuilder: (context, itemIndex) {
                              final menu = item.menuItems[itemIndex];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 1),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://xnova.nyanlinhtet.com/${menu.image}',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              StackTrace) =>
                                          const Icon(Icons.image_not_supported,
                                              size: 70.0, color: Colors.grey),
                                    ),
                                  ),
                                  title: Text(
                                    menu.name,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    "${menu.price} MMK",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            //padding: EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              "Menu will Soon",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          );
  }
}
