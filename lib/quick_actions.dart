// quick_actions.dart
import 'package:flutter/material.dart';
import 'package:myapp/order_bottom_sheet.dart'; // Import the bottom sheet widget
import 'package:myapp/quickAction_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0), // Add bottom margin here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Quick actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8.0), // Add spacing between Quick actions title and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuickActionButton(
                icon: Icons.add_box,
                text: 'Add\norder',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return OrderBottomSheet();
                    },
                  ).then((selectedOption) {
                    if (selectedOption != null) {
                      // Handle the selected option
                      print('Selected option: $selectedOption');
                    }
                  });
                },
              ),
              const QuickActionButton(
                icon: Icons.calculate,
                text: 'Rates\nCalculator',
              ),
              const QuickActionButton(
                icon: Icons.qr_code_scanner,
                text: 'Track\nOrder',
              ),
              const QuickActionButton(
                icon: Icons.calendar_month,
                text: 'Cargo\nCalendar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
