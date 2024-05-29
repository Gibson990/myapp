import 'package:flutter/material.dart';
import 'package:myapp/quickAction_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0), // Add bottom margin here
      child: const Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
          SizedBox(height: 8.0), // Add spacing between Quick actions title and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuickActionButton(
                icon: Icons.add_box,
                text: 'Add\norder',
              ),
              QuickActionButton(
                icon: Icons.calculate,
                text: 'Rates\nCalculator',
              ),
              QuickActionButton(
                icon: Icons.qr_code_scanner,
                // icon: MdiIcons.barcodeScan
                text: 'Track\nOrder',
                
              ),
               QuickActionButton(
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
