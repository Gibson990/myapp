import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'schedule_card.dart';
import 'future_schedule_buttons.dart';
// import '../utils/helpers.dart';

class CalendarSection extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedStartDate;
  final List<Map<String, String>> selectedDaySchedules;
  final List<Map<String, String>> currentMonthSchedules;
  final List<Map<String, String>> futureSchedules;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onFutureDateSelect;
  final Function(DateTime) onPageChanged;
  final List<Map<String, String>> availableDates; // Add this property

  const CalendarSection({
    Key? key,
    required this.focusedDay,
    this.selectedStartDate,
    required this.selectedDaySchedules,
    required this.currentMonthSchedules,
    required this.futureSchedules,
    required this.onDaySelected,
    required this.onFutureDateSelect,
    required this.onPageChanged,
    required this.availableDates, // Add this property
  }) : super(key: key);

  Widget _buildNoScheduleMessage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.event_busy, color: Colors.red),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'No schedules available on ${selectedStartDate?.day}/${selectedStartDate?.month}/${selectedStartDate?.year}',
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          // Check if there are any schedules after the selected date
          if (futureSchedules.where((schedule) {
            final scheduleDate = DateTime.parse(schedule['date']!);
            return scheduleDate.isAfter(selectedStartDate ?? DateTime.now());
          }).isNotEmpty) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Future Schedules Available!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Select from upcoming available dates:',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 12),
                  FutureScheduleButtons(
                    futureData: futureSchedules,
                    onDateSelected: onFutureDateSelect,
                  ),
                ],
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'No future schedules are currently available for this route.',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            selectedStartDate != null
                ? 'Schedules for ${selectedStartDate!.day}/${selectedStartDate!.month}/${selectedStartDate!.year}'
                : 'Available Schedules',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: TableCalendar(
            firstDay: DateTime(2023, 1, 1),
            lastDay: DateTime(2025, 12, 31),
            focusedDay: focusedDay,
            currentDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(selectedStartDate, day),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orange.shade200,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: Colors.black),
              weekendTextStyle: TextStyle(color: Colors.red),
              markerDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: (day) {
              // Mark days that have schedules
              return availableDates
                  .where((schedule) =>
                      isSameDay(DateTime.parse(schedule['date']!), day))
                  .map((_) => 'Available')
                  .toList();
            },
            onDaySelected: onDaySelected,
            onPageChanged: onPageChanged,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
        ),
        SizedBox(height: 20),
        if (selectedDaySchedules.isEmpty)
          _buildNoScheduleMessage()
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedDaySchedules
                  .map((schedule) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ScheduleCard(schedule: schedule),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
