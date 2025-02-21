import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 3,
        right: 3,
      ),
      child: BottomAppBar(
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                navItem(
                  FeatherIcons.home,
                  'Home',
                  pageIndex == 0,
                  onTap: () => onTap(0),
                ),
                navItem(
                  Icons.wallet_giftcard,
                  'Promos',
                  pageIndex == 1,
                  onTap: () => onTap(1),
                ),
                navItem(Icons.qr_code_sharp, 'Points', pageIndex == 2,
                    onTap: () => onTap(2)),
                navItem(
                  FeatherIcons.calendar,
                  'Calender',
                  pageIndex == 3,
                  onTap: () => onTap(3),
                ),
                navItem(FeatherIcons.messageCircle, 'Noti', pageIndex == 4,
                    onTap: () => onTap(4)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, label, bool selected, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? Colors.cyan[800] : Colors.grey[500],
              ),
              label
            ],
          )),
    );
  }
}
