import 'package:flutter/material.dart';

class ShippingMethodSelector extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodSelected;

  const ShippingMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMethodButton('Air', selectedMethod == 'air', () {
          onMethodSelected('air');
        }),
        SizedBox(width: 10),
        _buildMethodButton('Sea', selectedMethod == 'sea', () {
          onMethodSelected('sea');
        }),
      ],
    );
  }

  Widget _buildMethodButton(String label, bool isSelected, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.orange : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius:
              isSelected ? BorderRadius.circular(10) : BorderRadius.zero,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 12), // Adjusted padding for consistency
        shadowColor: Colors.transparent, // Remove shadow color
        animationDuration: Duration(milliseconds: 200), // Smooth animation
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) Icon(Icons.check, color: Colors.white, size: 16),
          if (isSelected) SizedBox(width: 4), // Reduced spacing
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal, // Removed boldness
            ),
          ),
        ],
      ),
    );
  }
}
