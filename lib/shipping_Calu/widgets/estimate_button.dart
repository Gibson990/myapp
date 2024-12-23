import 'package:flutter/material.dart';
import 'package:test_screens/screens/shipping_rate_estimate_screen.dart';
import 'package:test_screens/utils/constants.dart';

const Color customOrange = Color(0xFFFFA500); // Define customOrange color

class EstimateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function calculateShippingCost;
  final TextEditingController fromCountryController;
  final TextEditingController fromCityController;
  final TextEditingController toCountryController;
  final TextEditingController toCityController;
  final TextEditingController weightController;
  final String selectedGoodsType;
  final TextEditingController lengthController;
  final TextEditingController breadthController;
  final TextEditingController heightController;
  final TextEditingController cbmController;
  final TabController tabController;
  final List<String> portCities;
  final Map<String, List<String>> countryCityMap;

  const EstimateButton({
    Key? key,
    required this.formKey,
    required this.calculateShippingCost,
    required this.fromCountryController,
    required this.fromCityController,
    required this.toCountryController,
    required this.toCityController,
    required this.weightController,
    required this.selectedGoodsType,
    required this.lengthController,
    required this.breadthController,
    required this.heightController,
    required this.cbmController,
    required this.tabController,
    required this.portCities,
    required this.countryCityMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: customOrange,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Define a value for borderRadius
          ),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            String fromCountry = fromCountryController.text;
            String fromCity = fromCityController.text;
            String toCountry = toCountryController.text;
            String toCity = toCityController.text;
            String shippingMethod = tabController.index == 0
                ? 'Land'
                : tabController.index == 1
                    ? 'Air'
                    : 'Sea';

            if (fromCountry == toCountry && fromCity == toCity) {
              _showErrorDialog(
                  context, 'Shipping within the same city is not allowed.');
              return;
            }

            if (shippingMethod == 'Land' &&
                fromCountry != toCountry &&
                !countries.contains(fromCountry) &&
                !countries.contains(toCountry)) {
              _showErrorDialog(context,
                  'Land shipping is only allowed within the same country or between countries connected by land routes.');
              return;
            }

            if (shippingMethod == 'Sea' &&
                (!portCities.contains(fromCity) ||
                    !portCities.contains(toCity))) {
              _showErrorDialog(context,
                  'Sea shipping is only allowed between cities with access to ports.');
              return;
            }

            if ((shippingMethod == 'Sea' || shippingMethod == 'Air') &&
                fromCountry == toCountry) {
              _showErrorDialog(context,
                  'International shipping methods (Sea, Air) are not allowed within the same country.');
              return;
            }

            if ((shippingMethod == 'Air' || shippingMethod == 'Sea') &&
                fromCountry == toCountry &&
                countryCityMap[fromCountry]!.contains(fromCity) &&
                countryCityMap[toCountry]!.contains(toCity)) {
              _showErrorDialog(context,
                  'Air or Sea shipping is not allowed for short distances within the same country where land shipping is more practical.');
              return;
            }

            double shippingCost = calculateShippingCost();
            double? cbm = tabController.index == 2
                ? double.tryParse(cbmController.text)
                : null;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShippingRateEstimateScreen(
                  shippingCost: shippingCost,
                  fromCountry: fromCountry,
                  fromCity: fromCity,
                  toCountry: toCountry,
                  toCity: toCity,
                  weight: double.tryParse(weightController.text) ?? 0.0,
                  goodsType: selectedGoodsType,
                  length: double.tryParse(lengthController.text) ?? 0.0,
                  width: double.tryParse(breadthController.text) ?? 0.0,
                  height: double.tryParse(heightController.text) ?? 0.0,
                  shippingMethod: shippingMethod,
                  cbm: cbm,
                ),
              ),
            );
          }
        },
        child: const Text(
          'Estimate',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
