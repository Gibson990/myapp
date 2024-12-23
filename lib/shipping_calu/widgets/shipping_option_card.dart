import 'package:flutter/material.dart';

class ShippingOptionCard extends StatelessWidget {
  final String title;
  final String cost;
  final String weight;

  const ShippingOptionCard({
    super.key,
    required this.title,
    required this.cost,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding =
        screenWidth < 600 ? 12 : 18; // Adjust padding for small screens

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Cost',
                  style: TextStyle(
                    fontSize: screenWidth < 600
                        ? 12
                        : 14, // Adjust font size for small screens
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  cost,
                  style: TextStyle(
                    fontSize: screenWidth < 600
                        ? 10
                        : 12, // Adjust font size for small screens
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Weight',
                  style: TextStyle(
                    fontSize: screenWidth < 600
                        ? 12
                        : 14, // Adjust font size for small screens
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  weight,
                  style: TextStyle(
                    fontSize: screenWidth < 600
                        ? 10
                        : 12, // Adjust font size for small screens
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -10,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth < 600
                      ? 11
                      : 13, // Adjust font size for small screens
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
