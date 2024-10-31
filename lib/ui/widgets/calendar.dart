import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../shared/theme.dart';

class Calendar extends StatefulWidget {
  final DateTime selected;
  final void Function(DateTime) onSelected;

  const Calendar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  late DateTime _focusedDay = DateTime.now();

  bool _isAvailableDay(DateTime day) {
    return [DateTime.utc(2024, 10, 6), DateTime.utc(2024, 10, 7)].contains(day);
  }

  bool _isFullDay(DateTime day) {
    return [DateTime.utc(2024, 10, 5), DateTime.utc(2024, 10, 8)].contains(day);
  }

  @override
  Widget build(BuildContext context) {
    DateTime firstDay = DateTime.utc(2024, 1, 1);
    DateTime lastDay = DateTime.utc(2025, 12, 31);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: greyColor,
              width: 1,
            ),
          ),
          child: TableCalendar(
            firstDay: firstDay,
            lastDay: lastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, widget.selected),
            onDaySelected: (selectedDay, focusedDay) {
              if (_isAvailableDay(selectedDay)) {
                widget.onSelected(selectedDay); // Call the onSelected callback
                setState(() {
                  _focusedDay = focusedDay; // Update the focused day
                });
              }
            },
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle:
                  blackText.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            calendarStyle: CalendarStyle(
              defaultTextStyle: blackText,
              weekendTextStyle: blackText,
              todayTextStyle: blackText,
              todayDecoration: BoxDecoration(
                border: Border.all(color: greyColor),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: blueColor,
                shape: BoxShape.circle,
              ),
              disabledTextStyle: greyText.copyWith(fontSize: 12),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: blackText,
              weekendStyle: redText,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_isFullDay(day)) {
                  // Unavailable (full) - Red
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: lightRedColor,
                      shape: BoxShape.rectangle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: blackText,
                    ),
                  );
                } else if (_isAvailableDay(day)) {
                  // Available (green)
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: lightGreenColor,
                      shape: BoxShape.rectangle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: blackText,
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: greenColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Tersedia',
              style: blackText,
            ),
            const SizedBox(width: 24),
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: redColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Penuh',
              style: blackText,
            )
          ],
        )
      ],
    );
  }
}
