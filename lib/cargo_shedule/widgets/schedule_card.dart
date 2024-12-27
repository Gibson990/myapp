import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ScheduleCard extends StatelessWidget {
  final Map<String, String> schedule;

  const ScheduleCard({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    final isAir = schedule['type']!.toLowerCase().contains('airplane');
    final priceText = isAir
        ? '\$${AIR_PRICE_PER_10KG.toStringAsFixed(2)}/10kg'
        : '\$${SEA_PRICE_PER_CBM.toStringAsFixed(2)}/CBM';

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.0), // Add spacing between cards
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    schedule['type']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    priceText,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('From: ${schedule['departure']}'),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'To: ${schedule['arrival']}',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date: ${schedule['date']}'),
                  Icon(
                    isAir ? Icons.flight : Icons.directions_boat,
                    color: Colors.orange,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
