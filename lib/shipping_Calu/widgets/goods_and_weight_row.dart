import 'package:flutter/material.dart';

class GoodsAndWeightRow extends StatelessWidget {
  final double padding;
  final String selectedGoodsType;
  final TextEditingController weightController;
  final ValueChanged<String?> onGoodsTypeChanged;

  const GoodsAndWeightRow({
    Key? key,
    required this.padding,
    required this.selectedGoodsType,
    required this.weightController,
    required this.onGoodsTypeChanged,
  }) : super(key: key);

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey), // Set hint text color to gray
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Goods Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    _buildGoodsTypeDropdown(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weight',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    _buildWeightField(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoodsTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedGoodsType,
      decoration: _buildInputDecoration('Select Goods Type'),
      items: ['Select', 'Electronics', 'Clothing', 'Food', 'Furniture', 'Other']
          .map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: onGoodsTypeChanged,
      validator: (value) {
        if (value == 'Select') {
          return 'Please select a goods type';
        }
        return null;
      },
    );
  }

  Widget _buildWeightField() {
    return TextFormField(
      controller: weightController,
      keyboardType: TextInputType.number,
      decoration: _buildInputDecoration('Weight (kg)'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter weight';
        }
        return null;
      },
    );
  }
}
