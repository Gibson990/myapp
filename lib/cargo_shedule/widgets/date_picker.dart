import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;
  final DateTime? minDate;
  final String? errorText; // Add error text support

  const DatePicker({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.initialDate,
    this.minDate,
    this.errorText,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: widget.minDate ?? DateTime(2020), // Update this line
          lastDate: DateTime(2025),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
          widget.onDateSelected(pickedDate);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
          floatingLabelBehavior:
              FloatingLabelBehavior.never, // Remove floating text
        ),
        child: Text(
          _selectedDate != null
              ? "${_selectedDate!.toLocal()}".split(' ')[0]
              : widget.label,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
