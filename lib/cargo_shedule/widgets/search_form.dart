import 'package:flutter/material.dart';
import 'location_search_field.dart';
import 'date_picker.dart';

class SearchForm extends StatelessWidget {
  final String? fromLocation;
  final String? toLocation;
  final String? fromError;
  final String? toError;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final List<String> availableDepartures;
  final List<String> availableArrivals;
  final Function(String) onFromChanged;
  final Function(String) onToChanged;
  final Function(DateTime) onStartDateSelected;
  final Function(DateTime) onEndDateSelected;
  final VoidCallback onSearch;
  final TextEditingController fromController;
  final TextEditingController toController;

  const SearchForm({
    Key? key,
    required this.fromLocation,
    required this.toLocation,
    this.fromError,
    this.toError,
    this.selectedStartDate,
    this.selectedEndDate,
    required this.availableDepartures,
    required this.availableArrivals,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onStartDateSelected,
    required this.onEndDateSelected,
    required this.onSearch,
    required this.fromController,
    required this.toController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationSearchField(
                        hint: 'From',
                        value: fromController.text,
                        suggestions: availableDepartures,
                        onChanged: (value) {
                          fromController.text = value;
                          onFromChanged(value);
                        },
                        onSelected: (value) {
                          fromController.text = value;
                          onFromChanged(value);
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      if (fromError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text(
                            fromError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationSearchField(
                        hint: 'To',
                        value: toController.text,
                        suggestions: availableArrivals,
                        onChanged: (value) {
                          toController.text = value;
                          onToChanged(value);
                        },
                        onSelected: (value) {
                          toController.text = value;
                          onToChanged(value);
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      if (toError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text(
                            toError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DatePicker(
                    label: 'Start Date',
                    onDateSelected: onStartDateSelected,
                    initialDate: selectedStartDate,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DatePicker(
                    label: 'End Date',
                    onDateSelected: onEndDateSelected,
                    initialDate: selectedEndDate,
                    minDate: selectedStartDate,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Search Schedules',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
