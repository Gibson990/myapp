import 'package:flutter/material.dart';
import 'package:myapp/shipping_calu/utils/constants.dart';


class LocationSection extends StatefulWidget {
  final double padding;
  final TextEditingController fromCountryController;
  final TextEditingController fromCityController;
  final TextEditingController toCountryController;
  final TextEditingController toCityController;
  final List<String> countries;
  final Map<String, List<String>> countryCityMap;

  const LocationSection({
    super.key,
    required this.padding,
    required this.fromCountryController,
    required this.fromCityController,
    required this.toCountryController,
    required this.toCityController,
    required this.countries,
    required this.countryCityMap,
  });

  @override
  _LocationSectionState createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  @override
  void initState() {
    super.initState();
    _updateCities();
  }

  void _updateCities() {
    setState(() {});
  }

  InputDecoration _buildInputDecoration(String hintText,
      {bool isTop = true, bool isBottom = true}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          topRight: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          bottomLeft: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
          bottomRight: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          topRight: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          bottomLeft: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
          bottomRight: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
        ),
        borderSide: const BorderSide(color: customOrange),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          topRight: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          bottomLeft: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
          bottomRight: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
        ),
        borderSide: const BorderSide(color: customGrey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          topRight: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          bottomLeft: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
          bottomRight: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
        ),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          topRight: isTop ? const Radius.circular(borderRadius) : Radius.zero,
          bottomLeft: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
          bottomRight: isBottom ? const Radius.circular(borderRadius) : Radius.zero,
        ),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding * 0.5),
      child: Row(
        children: [
          Expanded(
            child: _buildLocationColumn('From', widget.fromCountryController,
                widget.fromCityController),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLocationColumn(
                'To', widget.toCountryController, widget.toCityController),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationColumn(
      String title,
      TextEditingController countryController,
      TextEditingController cityController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: _buildLocationDropdowns(countryController, cityController),
        ),
      ],
    );
  }

  Widget _buildLocationDropdowns(TextEditingController countryController,
      TextEditingController cityController) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: countryController.text.isEmpty ? null : countryController.text,
          hint: const Text('Country'),
          items: widget.countries.map<DropdownMenuItem<String>>((country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              countryController.text = newValue ?? '';
              cityController.clear();
              _updateCities();
            });
          },
          decoration: _buildInputDecoration('Country', isBottom: false),
        ),
        const Divider(height: 0, color: Colors.grey),
        DropdownButtonFormField<String>(
          value: cityController.text.isEmpty ? null : cityController.text,
          hint: const Text('City'),
          items: (countryController.text.isEmpty
                  ? []
                  : widget.countryCityMap[countryController.text] ?? [])
              .map<DropdownMenuItem<String>>((city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              cityController.text = newValue ?? '';
            });
          },
          decoration: _buildInputDecoration('City', isTop: false),
        ),
      ],
    );
  }
}
