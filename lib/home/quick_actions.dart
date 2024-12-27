import 'package:flutter/material.dart';
import 'package:myapp/barcode_scanner/barcode_scanner.dart';
import 'package:myapp/add_order/order_bottom_sheet.dart';


import 'package:myapp/shipping_calu/screens/shipping_calculator_screen.dart';

import '../cargo_shedule/cargo_schedule.dart';
// Import the bottom sheet widget

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
          const SizedBox(
              height:
                  8.0), // Add spacing between Quick actions title and buttons
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isSmallScreen = constraints.maxWidth < 400;
              final double iconSize =
                  isSmallScreen ? 40.0 : 48.0; // Icon size for responsiveness
              final double cardSize =
                  isSmallScreen ? 72.0 : 88.0; // Card size for responsiveness

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuickActionButton(
                    icon: Icons.add_box,
                    text: 'Add\nOrder',
                    iconSize: iconSize,
                    cardSize: cardSize,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const OrderBottomSheet();
                        },
                      ).then((selectedOption) {
                        if (selectedOption != null) {
                          debugPrint('Selected option: $selectedOption');
                        }
                      });
                    },
                  ),
                  QuickActionButton(
                    icon: Icons.calculate,
                    text: 'Rates\nCalculator',
                    iconSize: iconSize,
                    cardSize: cardSize,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShippingCalculatorScreen(),
                      ),
                    ),
                  ),
                  QuickActionButton(
                    icon: Icons.qr_code_scanner,
                    text: 'Track\nOrder',
                    iconSize: iconSize,
                    cardSize: cardSize,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BarcodeScanner(),
                      ),
                    ),
                  ),
                  QuickActionButton(
                    icon: Icons.calendar_month,
                    text: 'Cargo\nCalendar',
                    iconSize: iconSize,
                    cardSize: cardSize,
                     onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CargoScheduleWidget(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final double cardSize;
  final VoidCallback? onPressed;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize = 48.0,
    this.cardSize = 88.0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: cardSize,
        width: cardSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 4.0),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: cardSize / 8,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
