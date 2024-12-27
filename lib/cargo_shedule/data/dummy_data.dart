class ScheduleLocation {
  final String city;
  final String country;

  const ScheduleLocation(this.city, this.country);

  @override
  String toString() => '$city, $country';
}

class CargoSchedule {
  final String type;
  final ScheduleLocation departure;
  final ScheduleLocation arrival;
  final String date;

  const CargoSchedule({
    required this.type,
    required this.departure,
    required this.arrival,
    required this.date,
  });

  Map<String, String> toMap() => {
    'type': type,
    'departure': departure.toString(),
    'arrival': arrival.toString(),
    'date': date,
  };
}

final List<CargoSchedule> schedules = [
  CargoSchedule(
    type: 'Airplane',
    departure: ScheduleLocation('DSM', 'Tanzania'),
    arrival: ScheduleLocation('Shanghai', 'China'),
    date: '2024-05-01',
  ),
  CargoSchedule(
    type: 'Ship',
    departure: ScheduleLocation('Zanzibar', 'Tanzania'),
    arrival: ScheduleLocation('Ningbo', 'China'),
    date: '2024-05-10',
  ),
  CargoSchedule(
    type: 'Airplane',
    departure: ScheduleLocation('Kilimanjaro', 'Tanzania'),
    arrival: ScheduleLocation('Guangzhou', 'China'),
    date: '2024-06-15',
  ),
  CargoSchedule(
    type: 'Airplane',
    departure: ScheduleLocation('Nairobi', 'Kenya'),
    arrival: ScheduleLocation('New York', 'USA'),
    date: '2024-06-20',
  ),
  CargoSchedule(
    type: 'Ship',
    departure: ScheduleLocation('Mombasa', 'Kenya'),
    arrival: ScheduleLocation('Mumbai', 'India'),
    date: '2024-06-25',
  ),
  CargoSchedule(
    type: 'Airplane',
    departure: ScheduleLocation('DSM', 'Tanzania'),
    arrival: ScheduleLocation('Shanghai', 'China'),
    date: '2024-07-01',
  ),
  CargoSchedule(
    type: 'Ship',
    departure: ScheduleLocation('Zanzibar', 'Tanzania'),
    arrival: ScheduleLocation('Ningbo', 'China'),
    date: '2024-07-10',
  ),
  CargoSchedule(
    type: 'Airplane',
    departure: ScheduleLocation('Kilimanjaro', 'Tanzania'),
    arrival: ScheduleLocation('Guangzhou', 'China'),
    date: '2024-08-15',
  ),
  CargoSchedule(
    type: 'Airplane',
    departure: ScheduleLocation('Nairobi', 'Kenya'),
    arrival: ScheduleLocation('New York', 'USA'),
    date: '2024-08-20',
  ),
  CargoSchedule(
    type: 'Ship',
    departure: ScheduleLocation('Mombasa', 'Kenya'),
    arrival: ScheduleLocation('Mumbai', 'India'),
    date: '2024-08-25',
  ),
];

// For backward compatibility with existing code
final List<Map<String, String>> scheduleData = schedules.map((s) => s.toMap()).toList();

// Helper functions for location matching
bool matchesLocation(String scheduleLocation, String searchTerm) {
  if (searchTerm.isEmpty) return true;
  
  final parts = scheduleLocation.toLowerCase().split(',');
  final country = parts.last.trim();
  final city = parts.first.trim();
  final search = searchTerm.toLowerCase().trim();
  
  return country == search || city == search;
}

// Get unique countries
List<String> getUniqueCountries(List<CargoSchedule> schedules, bool isArrival) {
  return schedules
      .map((s) => isArrival ? s.arrival.country : s.departure.country)
      .toSet()
      .toList()
    ..sort();
}

