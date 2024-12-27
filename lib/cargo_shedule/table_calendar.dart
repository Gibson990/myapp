import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class TableCalendarWidget extends StatefulWidget {
  final Function(DateTime selectedDate) onDateSelected;
  final DateTime? initialDate;

  const TableCalendarWidget({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  @override
  State<TableCalendarWidget> createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  late DateTime _focusedDate;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.initialDate ?? DateTime.now();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
          focusedDay: _focusedDate,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDate, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDate = selectedDay;
              _focusedDate = focusedDay;
            });
            widget.onDateSelected(selectedDay);
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(color: Colors.black),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.orange),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
