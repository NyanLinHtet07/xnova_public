import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xnova/utilities/drawer.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _Calender();
}

class _Calender extends State<Calender> {
  CalendarFormat _calenderFormat = CalendarFormat.month;
  DateTime _selectDay = DateTime.now();
  DateTime _focusDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(FeatherIcons.grid),
                iconSize: 28.0,
                color: Colors.cyan[800],
              ),
            )
          ],
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset(
              'assets/xnova_icon.png',
              height: 80,
              width: 80,
            ),
          ]),
          backgroundColor: Colors.white,
        ),
        endDrawer: Drawer(
          child: MainDrawer(),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text("Calander"),
            ),
            Expanded(
              child: TableCalendar(
                focusedDay: _focusDay,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                calendarFormat: _calenderFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calenderFormat = format;
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectDay = selectedDay;
                    _focusDay = focusedDay;
                  });
                },
              ),
            )
          ],
        ));
  }
}
