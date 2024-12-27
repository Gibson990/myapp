import 'package:flutter/material.dart';

class FutureScheduleButtons extends StatelessWidget {
  final List<Map<String, String>> futureData;
  final Function(DateTime) onDateSelected;

  const FutureScheduleButtons({
    super.key,
    required this.futureData,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonWidth = (constraints.maxWidth - 16) /
            2; // 2 buttons per row with 16px spacing
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: futureData.take(6).map((schedule) {
            final date = DateTime.parse(schedule['date']!);
            return InkWell(
              onTap: () => onDateSelected(date),
              child: Container(
                width: buttonWidth,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16, color: Colors.orange.shade700),
                    SizedBox(width: 8),
                    Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
