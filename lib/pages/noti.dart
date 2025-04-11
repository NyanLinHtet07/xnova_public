import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:xnova/utilities/drawer.dart';

class Noti extends StatelessWidget {
  const Noti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   Builder(
        //       builder: (context) => IconButton(
        //             onPressed: () {
        //               Scaffold.of(context).openEndDrawer();
        //             },
        //             icon: Icon(FeatherIcons.grid),
        //             iconSize: 28.0,
        //             color: Colors.cyan[800],
        //           ))
        // ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/xnova_icon.png',
              height: 80,
              width: 80,
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      // endDrawer: Drawer(
      //   child: MainDrawer(),
      // ),
      body: Center(
        child: Text('Hello Notifications'),
      ),
    );
  }
}
