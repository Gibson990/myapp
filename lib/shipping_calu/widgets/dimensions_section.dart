import 'package:flutter/material.dart';
import 'package:myapp/shipping_calu/utils/constants.dart';


class DimensionsSection extends StatelessWidget {
  final double padding;
  final String selectedDimensionUnit;
  final TextEditingController lengthController;
  final TextEditingController breadthController;
  final TextEditingController heightController;
  final TextEditingController cbmController;
  final ValueChanged<String?> onDimensionUnitChanged;
  final VoidCallback onDimensionChanged;
  final bool showCBMField;

  const DimensionsSection({
    super.key,
    required this.padding,
    required this.selectedDimensionUnit,
    required this.lengthController,
    required this.breadthController,
    required this.heightController,
    required this.cbmController,
    required this.onDimensionUnitChanged,
    required this.onDimensionChanged,
    required this.showCBMField,
  });

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey), // Set hint text color to gray
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: customOrange),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: customGrey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (double.tryParse(value) == null || double.parse(value) <= 0) {
      return 'Invalid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dimensions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text('Unit: '),
                  DropdownButton<String>(
                    value: selectedDimensionUnit,
                    items: dimensionUnits.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: onDimensionUnitChanged,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: lengthController,
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration('Length'),
                  onChanged: (value) => onDimensionChanged(),
                  validator: (value) {
                    if (showCBMField && cbmController.text.isEmpty) {
                      return _validateInput(value);
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: breadthController,
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration('Breadth'),
                  onChanged: (value) => onDimensionChanged(),
                  validator: (value) {
                    if (showCBMField && cbmController.text.isEmpty) {
                      return _validateInput(value);
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration('Height'),
                  onChanged: (value) => onDimensionChanged(),
                  validator: (value) {
                    if (showCBMField && cbmController.text.isEmpty) {
                      return _validateInput(value);
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Note: Dimension value should be greater than  ${selectedDimensionUnit == 'mm' ? '500' : selectedDimensionUnit == 'cm' ? '0.50' : '0.005'} $selectedDimensionUnit',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          if (showCBMField) ...[
            const SizedBox(height: 8),
            TextFormField(
              controller: cbmController,
              keyboardType: TextInputType.number,
              decoration: _buildInputDecoration('CBM'),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  lengthController.clear();
                  breadthController.clear();
                  heightController.clear();
                }
              },
              validator: (value) {
                if (lengthController.text.isEmpty ||
                    breadthController.text.isEmpty ||
                    heightController.text.isEmpty) {
                  return _validateInput(value);
                }
                return null;
              },
            ),
          ],
        ],
      ),
    );
  }
}
