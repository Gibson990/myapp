import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFF7F00), // Background color
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 32.0, // Set the height to 32px
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          border: Border.all(
            color: Theme.of(context).hintColor.withOpacity(0.5), // Faint outline color
            width: 1.0, // Width of the outline
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8.0), // Left padding for the search icon
            Icon(Icons.search, color: Theme.of(context).hintColor), // Search icon color
            const SizedBox(width: 8.0), // Padding between icon and text
            Expanded(
              child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Enter 10 digit tracking number',
                  hintStyle: TextStyle(color: Theme.of(context).hintColor), // Hint text color
                  border: InputBorder.none,
                  isCollapsed: true, // Ensures the content is centered
                ),
              ),
            ),
            const SizedBox(width: 8.0), // Padding between text and scanner icon
            Icon(Icons.qr_code_scanner, color: Theme.of(context).hintColor), // Barcode scanner icon color
            const SizedBox(width: 8.0), // Right padding for the scanner icon
          ],
        ),
      ),
    );
  }
}
