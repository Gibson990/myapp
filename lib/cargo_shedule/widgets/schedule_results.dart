import 'package:flutter/material.dart';
import 'schedule_card.dart';

class ScheduleResults extends StatelessWidget {
  final List<Map<String, String>> searchResults;
  final List<Map<String, String>> futureDates;
  final String? fromLocation;
  final String? toLocation;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function(DateTime) onFutureDateSelect;
  final bool isDateSelected;
  final bool isDateRangeSearch;

  const ScheduleResults({
    Key? key,
    required this.searchResults,
    required this.futureDates,
    this.fromLocation,
    this.toLocation,
    this.selectedStartDate,
    this.selectedEndDate,
    required this.onFutureDateSelect,
    required this.isDateSelected,
    required this.isDateRangeSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (searchResults.isEmpty)
          _buildNoResultsView()
        else
          _buildResultsView(),
      ],
    );
  }

  Widget _buildNoResultsView() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  selectedStartDate != null && selectedEndDate != null
                      ? 'No schedules found for $fromLocation to $toLocation between ${selectedStartDate!.toString().split(' ')[0]} and ${selectedEndDate!.toString().split(' ')[0]}'
                      : selectedStartDate != null
                          ? 'No schedules found for $fromLocation to $toLocation on ${selectedStartDate!.toString().split(' ')[0]}'
                          : 'No schedules found for $fromLocation to $toLocation',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          if (futureDates.isEmpty) ...[
            SizedBox(height: 8),
            Text(
              'No future schedules available for this route',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ] else ...[
            SizedBox(height: 16),
            Text(
              'Next available schedules for this route:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: futureDates.take(5).map((schedule) {
                final date = DateTime.parse(schedule['date']!);
                return InkWell(
                  onTap: () => onFutureDateSelect(date),
                  child: Container(
                    width: 85,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.orange.shade300,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}/${date.month}/${date.year}',
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isDateSelected || isDateRangeSearch
              ? selectedEndDate != null
                  ? 'Schedules between ${selectedStartDate!.toString().split(' ')[0]} and ${selectedEndDate!.toString().split(' ')[0]}'
                  : 'Schedules for ${selectedStartDate!.toString().split(' ')[0]}'
              : 'Available Schedules:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...searchResults.map((schedule) => ScheduleCard(schedule: schedule)),
      ],
    );
  }
}
