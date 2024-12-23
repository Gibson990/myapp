import 'package:flutter/material.dart';

class CBMSection extends StatelessWidget {
  final double padding;
  final bool isUsingCBM;
  final TextEditingController cbmController;

  const CBMSection({
    super.key,
    required this.padding,
    required this.isUsingCBM,
    required this.cbmController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CBM (Cubic Meters)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: cbmController,
            enabled: isUsingCBM,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter CBM directly',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 12.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xFFFF7F00)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            onChanged: (value) {
              // Add your onChanged logic here
              if (value.isNotEmpty) {
                // Perform any necessary actions when the value changes
                print('CBM value changed: $value');
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'CBM is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
