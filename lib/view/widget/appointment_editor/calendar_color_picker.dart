import 'package:flutter/material.dart';
import 'package:plato_calendar/etc/calendar_color.dart';

class CalendarColorPicker extends StatefulWidget {
  const CalendarColorPicker(this.calendarColor, {super.key});

  final int calendarColor;

  @override
  State<StatefulWidget> createState() => _CalendarColorPickerState();
}

class _CalendarColorPickerState extends State<CalendarColorPicker> {
  late int _calendarColor;

  @override
  void initState() {
    super.initState();
    _calendarColor = widget.calendarColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0),
        content: Container(
            alignment: Alignment.center,
            width: (calendarColor.length * 100).toDouble(),
            height: 50.0,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: Text(
                '색상',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: ListView.builder(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemCount: calendarColor.length,
                  itemBuilder: (context, i) {
                    return TextButton(
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.all(2.2),
                          // minWidth: 10,
                        ),
                        onPressed: () {
                          setState(() {
                            _calendarColor = i;
                          });
                          Future.delayed(const Duration(milliseconds: 200), () {
                            Navigator.pop(context, _calendarColor);
                          });
                        },
                        child: Icon(
                            i == _calendarColor
                                ? Icons.lens
                                : Icons.trip_origin,
                            color: calendarColor[i]));
                  }),
            )));
  }
}
