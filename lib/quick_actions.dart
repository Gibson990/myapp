import 'package:flutter/material.dart';
import 'package:myapp/quickAction_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Quick actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10), // Add spacing between Quick actions title and buttons
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
              icon: Icons.track_changes,
              text: 'Track\nOrder',
              
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Cargo\n',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Calendar',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
