import 'package:flutter/material.dart';
import 'widgets/calendar_section.dart';
import 'widgets/search_form.dart';
import 'widgets/schedule_results.dart';
import 'widgets/shipping_method_selector.dart';
import 'data/dummy_data.dart' as data;
// import 'package:table_calendar/table_calendar.dart';

class CargoScheduleWidget extends StatefulWidget {
  const CargoScheduleWidget({super.key});

  @override
  _CargoScheduleWidgetState createState() => _CargoScheduleWidgetState();
}

class _CargoScheduleWidgetState extends State<CargoScheduleWidget> {
  String? fromLocation;
  String? toLocation;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String selectedMethod = 'air';
  DateTime focusedDay = DateTime.now();
  bool isDateRangeSearch = false;
  bool hasSearched = false;
  bool showCalendar = true;
  bool isDateSelected =
      false; // Add new state variable to track the active view

  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  String? _fromError;
  String? _toError;

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  // Update location validation
  bool get _isValidSearch {
    bool isValid = true;
    setState(() {
      _fromError = null;
      _toError = null;

      if (fromLocation?.isEmpty ?? true) {
        _fromError = 'Please enter departure location';
        isValid = false;
      }
      if (toLocation?.isEmpty ?? true) {
        _toError = 'Please enter arrival location';
        isValid = false;
      }
    });
    return isValid;
  }

  bool get hasMatchingSchedules {
    return data.scheduleData.any((schedule) {
      final isMethodMatch = schedule['type']!
          .toLowerCase()
          .contains(selectedMethod == 'air' ? 'airplane' : 'ship');
      final isFromMatch = fromLocation == null ||
          data.matchesLocation(schedule['departure']!, fromLocation!);
      final isToMatch = toLocation == null ||
          data.matchesLocation(schedule['arrival']!, toLocation!);
      return isMethodMatch && isFromMatch && isToMatch;
    });
  }

  bool get shouldShowCalendar {
    if (!showCalendar) return false;
    return hasSearched && hasMatchingSchedules;
  }

  // Update the getters to extract unique countries from dummy data
  List<String> get availableDepartures =>
      data.getUniqueCountries(data.schedules, false);
  List<String> get availableArrivals =>
      data.getUniqueCountries(data.schedules, true);

  void _handleSearchModeChange() {
    if (!_isValidSearch) return;

    setState(() {
      hasSearched = true;
      isDateRangeSearch = selectedStartDate != null && selectedEndDate != null;
      showCalendar = false; // Always hide calendar initially after search
      isDateSelected = isDateRangeSearch || selectedStartDate != null;
    });
  }

  // Update calendar toggle to maintain search state
  void _toggleCalendar() {
    if (!_isValidSearch) return;

    setState(() {
      showCalendar = !showCalendar;
      if (showCalendar) {
        // Only reset end date if in date range mode
        if (isDateRangeSearch) {
          selectedEndDate = null;
          isDateRangeSearch = false;
        }
        // Focus on selected date if exists, otherwise current day
        focusedDay = selectedStartDate ?? DateTime.now();
      }
    });
  }

  void _handleCalendarDateSelect(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedStartDate = selectedDay;
      this.focusedDay = focusedDay;
      isDateSelected = true; // Mark that a date is selected
      // Don't hide calendar when selecting a date
    });
  }

  void _handleFutureDateSelect(DateTime date) {
    setState(() {
      selectedStartDate = date;
      selectedEndDate = null;
      showCalendar = true;
      isDateRangeSearch = false;
      isDateSelected = true;
      focusedDay = date;
      hasSearched = true;
    });
  }

  void _handleStartDateSelected(DateTime date) {
    setState(() {
      selectedStartDate = date;
      isDateSelected = true;

      // If end date is before start date, reset it
      if (selectedEndDate != null && selectedEndDate!.isBefore(date)) {
        selectedEndDate = null;
      }

      // If no end date is set, use current date only if it's after start date
      if (selectedEndDate == null) {
        final now = DateTime.now();
        selectedEndDate = now.isAfter(date) ? now : date;
      }

      showCalendar = false;
      isDateRangeSearch = true;
    });
  }

  void _handleEndDateSelected(DateTime date) {
    if (selectedStartDate != null && date.isBefore(selectedStartDate!)) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('End date cannot be before start date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      selectedEndDate = date;
      if (selectedStartDate != null) {
        showCalendar = false;
        isDateRangeSearch = true;
      }
    });
  }

  List<Map<String, String>> _getFilteredSchedules() {
    var schedules = data.schedules.where((schedule) {
      final isMethodMatch = schedule.type
          .toLowerCase()
          .contains(selectedMethod == 'air' ? 'airplane' : 'ship');
      if (!isMethodMatch) return false;

      // Location filter
      final isFromMatch = fromLocation == null ||
          data.matchesLocation(schedule.departure.toString(), fromLocation!);
      final isToMatch = toLocation == null ||
          data.matchesLocation(schedule.arrival.toString(), toLocation!);
      if (!isFromMatch || !isToMatch) return false;

      // Date filter
      if (selectedStartDate != null) {
        final scheduleDate = DateTime.parse(schedule.date);
        if (selectedEndDate != null) {
          return scheduleDate
                  .isAfter(selectedStartDate!.subtract(Duration(days: 1))) &&
              scheduleDate.isBefore(selectedEndDate!.add(Duration(days: 1)));
        }
        return isSameDay(scheduleDate, selectedStartDate!);
      }

      return true;
    }).toList();

    return schedules.map((s) => s.toMap()).toList()
      ..sort((a, b) =>
          DateTime.parse(a['date']!).compareTo(DateTime.parse(b['date']!)));
  }

  // Replace filteredScheduleData getter
  List<Map<String, String>> get filteredScheduleData => _getFilteredSchedules();

  List<Map<String, String>> get futureScheduleData {
    return data.schedules
        .where((schedule) {
          final isMethodMatch = schedule.type
              .toLowerCase()
              .contains(selectedMethod == 'air' ? 'airplane' : 'ship');
          final scheduleDate = DateTime.parse(schedule.date);
          final isFutureDate = scheduleDate.isAfter(
              DateTime(focusedDay.year, focusedDay.month, focusedDay.day));

          final isFromMatch = fromLocation == null ||
              data.matchesLocation(
                  schedule.departure.toString(), fromLocation!);
          final isToMatch = toLocation == null ||
              data.matchesLocation(schedule.arrival.toString(), toLocation!);

          return isMethodMatch && isFutureDate && isFromMatch && isToMatch;
        })
        .map((s) => s.toMap())
        .toList()
      ..sort((a, b) =>
          DateTime.parse(a['date']!).compareTo(DateTime.parse(b['date']!)));
  }

  // Fix the availableDates getter to return the correct type
  List<Map<String, String>> get availableDates {
    return data.schedules
        .where((schedule) {
          final isMethodMatch = schedule.type
              .toLowerCase()
              .contains(selectedMethod == 'air' ? 'airplane' : 'ship');

          final isFromMatch = fromLocation == null ||
              data.matchesLocation(
                  schedule.departure.toString(), fromLocation!);
          final isToMatch = toLocation == null ||
              data.matchesLocation(schedule.arrival.toString(), toLocation!);

          return isMethodMatch && isFromMatch && isToMatch;
        })
        .map((schedule) => schedule.toMap())
        .toList()
      ..sort((a, b) =>
          DateTime.parse(a['date']!).compareTo(DateTime.parse(b['date']!)));
  }

  List<String> get availableMonths {
    final months = data.schedules
        .where((schedule) {
          return schedule.type
              .toLowerCase()
              .contains(selectedMethod == 'air' ? 'airplane' : 'ship');
        })
        .map((schedule) {
          final date = DateTime.parse(schedule.date);
          return '${date.month}/${date.year}';
        })
        .toSet()
        .toList();
    return months;
  }

  // Update location matching logic
  bool _matchesLocation(String scheduleLocation, String searchTerm) {
    if (searchTerm.isEmpty) return true;

    // Split location into city and country
    final parts = scheduleLocation.toLowerCase().split(',');
    final scheduleCountry = parts.last.trim();
    final scheduleCity = parts.first.trim();

    // Match against either city or country
    return scheduleCountry.contains(searchTerm.toLowerCase()) ||
        scheduleCity.contains(searchTerm.toLowerCase());
  }

  // Update schedule filtering logic
  List<Map<String, String>> get searchedScheduleData {
    return data.schedules
        .where((schedule) {
          final isMethodMatch = schedule.type
              .toLowerCase()
              .contains(selectedMethod == 'air' ? 'airplane' : 'ship');

          final isFromMatch = data.matchesLocation(
              schedule.departure.toString(), fromLocation ?? '');
          final isToMatch = data.matchesLocation(
              schedule.arrival.toString(), toLocation ?? '');

          if (!isMethodMatch || !isFromMatch || !isToMatch) return false;

          if (selectedStartDate != null) {
            final scheduleDate = DateTime.parse(schedule.date);
            final endDate = selectedEndDate ?? DateTime.now();

            if (selectedEndDate != null) {
              return scheduleDate.isAfter(
                      selectedStartDate!.subtract(Duration(days: 1))) &&
                  scheduleDate
                      .isBefore(selectedEndDate!.add(Duration(days: 1)));
            }

            return scheduleDate
                    .isAfter(selectedStartDate!.subtract(Duration(days: 1))) &&
                scheduleDate.isBefore(endDate.add(Duration(days: 1)));
          }

          return true;
        })
        .map((s) => s.toMap())
        .toList()
      ..sort((a, b) =>
          DateTime.parse(a['date']!).compareTo(DateTime.parse(b['date']!)));
  }

  List<Map<String, String>> get futureDatesForLocation {
    final currentDate = selectedStartDate ?? DateTime.now();
    return data.scheduleData.where((schedule) {
      final scheduleDate = DateTime.parse(schedule['date']!);
      // Consider next day as future
      return scheduleDate.isAfter(currentDate) && _isValidSchedule(schedule);
    }).toList()
      ..sort((a, b) =>
          DateTime.parse(a['date']!).compareTo(DateTime.parse(b['date']!)));
  }

  List<Map<String, String>> get currentScheduleDisplay {
    if (isDateRangeSearch || isDateSelected) {
      return data.schedules
          .where((schedule) {
            final isMethodMatch = schedule.type
                .toLowerCase()
                .contains(selectedMethod == 'air' ? 'airplane' : 'ship');

            final isFromMatch = data.matchesLocation(
                schedule.departure.toString(), fromLocation ?? '');
            final isToMatch = data.matchesLocation(
                schedule.arrival.toString(), toLocation ?? '');

            if (!isMethodMatch || !isFromMatch || !isToMatch) return false;

            final scheduleDate = DateTime.parse(schedule.date);

            if (selectedEndDate != null) {
              return scheduleDate.isAfter(
                      selectedStartDate!.subtract(Duration(days: 1))) &&
                  scheduleDate
                      .isBefore(selectedEndDate!.add(Duration(days: 1)));
            } else if (selectedStartDate != null) {
              return isSameDay(scheduleDate, selectedStartDate!);
            }
            return false;
          })
          .map((s) => s.toMap())
          .toList()
        ..sort((a, b) =>
            DateTime.parse(a['date']!).compareTo(DateTime.parse(b['date']!)));
    } else {
      return searchedScheduleData;
    }
  }

  List<Map<String, String>> getSchedulesForMonth(DateTime month) {
    return data.scheduleData.where((schedule) {
      final scheduleDate = DateTime.parse(schedule['date']!);
      final isMethodMatch = schedule['type']!
          .toLowerCase()
          .contains(selectedMethod == 'air' ? 'airplane' : 'ship');

      final isFromMatch = fromLocation == null ||
          data.matchesLocation(schedule['departure']!, fromLocation!);
      final isToMatch = toLocation == null ||
          data.matchesLocation(schedule['arrival']!, toLocation!);

      return scheduleDate.month == month.month &&
          scheduleDate.year == month.year &&
          isMethodMatch &&
          isFromMatch &&
          isToMatch;
    }).toList()
      ..sort((a, b) =>
          DateTime.parse(a['date']!).compareTo(DateTime.parse(b['date']!)));
  }

  List<Map<String, String>> getFutureSchedules(DateTime afterDate) {
    return data.schedules
        .where((schedule) {
          final scheduleDate = DateTime.parse(schedule.date);
          final isMethodMatch = schedule.type
              .toLowerCase()
              .contains(selectedMethod == 'air' ? 'airplane' : 'ship');

          final isFromMatch = fromLocation == null ||
              data.matchesLocation(
                  schedule.departure.toString(), fromLocation!);
          final isToMatch = toLocation == null ||
              data.matchesLocation(schedule.arrival.toString(), toLocation!);

          // Check if the schedule is at least one day after
          return scheduleDate.isAfter(afterDate) &&
              isMethodMatch &&
              isFromMatch &&
              isToMatch;
        })
        .map((s) => s.toMap())
        .toList()
      ..sort((a, b) =>
          DateTime.parse(a['date']!).compareTo(DateTime.parse(b['date']!)));
  }

  List<Map<String, String>> getSchedulesForDay(DateTime day) {
    return data.schedules
        .where((schedule) {
          final scheduleDate = DateTime.parse(schedule.date);
          final isMethodMatch = schedule.type
              .toLowerCase()
              .contains(selectedMethod == 'air' ? 'airplane' : 'ship');
          final isFromMatch = fromLocation == null ||
              _matchesLocation(schedule.departure.toString(), fromLocation!);
          final isToMatch = toLocation == null ||
              _matchesLocation(schedule.arrival.toString(), toLocation!);

          return isSameDay(scheduleDate, day) &&
              isMethodMatch &&
              isFromMatch &&
              isToMatch;
        })
        .map((s) => s.toMap())
        .toList();
  }

  bool isSameDay(DateTime? dateA, DateTime? dateB) {
    if (dateA == null || dateB == null) return false;
    return dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
  }

  bool _isValidSchedule(Map<String, String> schedule) {
    final isMethodMatch = schedule['type']!
        .toLowerCase()
        .contains(selectedMethod == 'air' ? 'airplane' : 'ship');

    final isFromMatch = fromLocation == null ||
        data.matchesLocation(schedule['departure']!, fromLocation!);
    final isToMatch = toLocation == null ||
        data.matchesLocation(schedule['arrival']!, toLocation!);

    return isMethodMatch && isFromMatch && isToMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Cargo Calendar',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SearchForm(
            fromLocation: fromLocation,
            toLocation: toLocation,
            fromError: _fromError,
            toError: _toError,
            selectedStartDate: selectedStartDate,
            selectedEndDate: selectedEndDate,
            availableDepartures: availableDepartures,
            availableArrivals: availableArrivals,
            onFromChanged: (value) => setState(() => fromLocation = value),
            onToChanged: (value) => setState(() => toLocation = value),
            onStartDateSelected: _handleStartDateSelected,
            onEndDateSelected: _handleEndDateSelected,
            onSearch: _handleSearchModeChange,
            fromController: _fromController,
            toController: _toController,
          ),
          SizedBox(height: 16),
          ShippingMethodSelector(
            selectedMethod: selectedMethod,
            onMethodSelected: (method) =>
                setState(() => selectedMethod = method),
          ),
          if (hasSearched && hasMatchingSchedules) ...[
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: _toggleCalendar,
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  showCalendar ? 'Hide Calendar' : 'Show Calendar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (shouldShowCalendar)
              CalendarSection(
                focusedDay: focusedDay,
                selectedStartDate: selectedStartDate,
                selectedDaySchedules:
                    getSchedulesForDay(selectedStartDate ?? focusedDay),
                currentMonthSchedules: getSchedulesForMonth(focusedDay),
                futureSchedules: getFutureSchedules(focusedDay),
                availableDates: availableDates, // Add this property
                onDaySelected: _handleCalendarDateSelect,
                onFutureDateSelect: _handleFutureDateSelect,
                onPageChanged: (date) => setState(() => focusedDay = date),
              )
            else
              ScheduleResults(
                searchResults: currentScheduleDisplay,
                futureDates: futureDatesForLocation,
                fromLocation: fromLocation,
                toLocation: toLocation,
                selectedStartDate: selectedStartDate,
                selectedEndDate: selectedEndDate,
                onFutureDateSelect: _handleFutureDateSelect,
                isDateSelected: isDateSelected,
                isDateRangeSearch: isDateRangeSearch,
              ),
          ],
        ],
      ),
    );
  }

  // Add helper method for better date handling
  bool isValidScheduleDay(DateTime day) {
    final schedules = getSchedulesForDay(day);
    return schedules.isNotEmpty;
  }
}
