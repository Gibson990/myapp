import 'package:flutter/material.dart';
import 'package:test_screens/screens/shipping_rate_estimate_screen.dart';
import 'package:test_screens/widgets/shipping_options.dart';
import 'package:test_screens/widgets/tabs.dart';
import 'package:test_screens/widgets/goods_and_weight_row.dart';
import 'package:test_screens/widgets/dimensions_section.dart';
import 'package:test_screens/widgets/location_section.dart';
import 'package:test_screens/utils/constants.dart';

class ShippingCalculatorScreen extends StatefulWidget {
  const ShippingCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<ShippingCalculatorScreen> createState() =>
      _ShippingCalculatorScreenState();
}

class _ShippingCalculatorScreenState extends State<ShippingCalculatorScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _selectedGoodsType = 'Select';
  String _selectedDimensionUnit = 'cm';
  bool _isUsingCBM = false;

  final _weightController = TextEditingController();
  final _lengthController = TextEditingController();
  final _breadthController = TextEditingController();
  final _heightController = TextEditingController();
  final _cbmController = TextEditingController();
  final _fromCountryController = TextEditingController();
  final _fromCityController = TextEditingController();
  final _toCountryController = TextEditingController();
  final _toCityController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      _formKey.currentState?.reset();
      _weightController.clear();
      _lengthController.clear();
      _breadthController.clear();
      _heightController.clear();
      _cbmController.clear();
      _fromCountryController.clear();
      _fromCityController.clear();
      _toCountryController.clear();
      _toCityController.clear();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _weightController.dispose();
    _lengthController.dispose();
    _breadthController.dispose();
    _heightController.dispose();
    _cbmController.dispose();
    _fromCountryController.dispose();
    _fromCityController.dispose();
    _toCountryController.dispose();
    _toCityController.dispose();
    super.dispose();
  }

  double _convertToMeters(double value) {
    switch (_selectedDimensionUnit) {
      case 'mm':
        return value / 1000;
      case 'cm':
        return value / 100;
      case 'm':
        return value;
      default:
        return value / 100; // default to cm
    }
  }

  double calculateCBM() {
    double length = double.tryParse(_lengthController.text) ?? 0.0;
    double breadth = double.tryParse(_breadthController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;

    length = _convertToMeters(length);
    breadth = _convertToMeters(breadth);
    height = _convertToMeters(height);

    return length * breadth * height;
  }

  double calculateShippingCost() {
    double baseRate = _tabController.index == 1 ? 13.0 : 2.5;

    if (_tabController.index == 2) {
      // Sea shipping
      double cbm;
      if (_isUsingCBM) {
        cbm = double.tryParse(_cbmController.text) ?? 0.0;
      } else {
        cbm = calculateCBM();
      }
      return cbm * baseRate * 1000;
    } else {
      double weight = double.tryParse(_weightController.text) ?? 0.0;
      if (!_isUsingCBM) {
        double length = double.tryParse(_lengthController.text) ?? 0.0;
        double breadth = double.tryParse(_breadthController.text) ?? 0.0;
        double height = double.tryParse(_heightController.text) ?? 0.0;

        double volumetricWeight = (length * breadth * height) / 5000;
        weight = weight > volumetricWeight ? weight : volumetricWeight;
      }
      return weight * baseRate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth < 600 ? 14 : 18;
    final double spacingBetweenSections = screenWidth < 600 ? 16 : 24;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shipping Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: customOrange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShippingOptions(screenWidth: screenWidth),
              SizedBox(height: spacingBetweenSections),
              Tabs(tabController: _tabController),
              SizedBox(height: spacingBetweenSections * 0.75),
              GoodsAndWeightRow(
                padding: padding,
                selectedGoodsType: _selectedGoodsType,
                weightController: _weightController,
                onGoodsTypeChanged: (newValue) {
                  setState(() {
                    _selectedGoodsType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
                child: const Text(
                  'Note: The minimum chargeable weight is 0.50kg',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: spacingBetweenSections * 0.75),
              DimensionsSection(
                padding: padding,
                selectedDimensionUnit: _selectedDimensionUnit,
                lengthController: _lengthController,
                breadthController: _breadthController,
                heightController: _heightController,
                cbmController: _cbmController,
                onDimensionUnitChanged: (newValue) {
                  setState(() {
                    _selectedDimensionUnit = newValue!;
                    _cbmController.text = calculateCBM().toStringAsFixed(3);
                  });
                },
                onDimensionChanged: () {
                  setState(() {
                    _cbmController.text = calculateCBM().toStringAsFixed(3);
                  });
                },
                showCBMField: _tabController.index == 2,
              ),
              SizedBox(height: spacingBetweenSections),
              LocationSection(
                padding: padding,
                fromCountryController: _fromCountryController,
                fromCityController: _fromCityController,
                toCountryController: _toCountryController,
                toCityController: _toCityController,
                countries: countries,
                countryCityMap: countryCityMap,
              ),
              SizedBox(height: spacingBetweenSections),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: _buildEstimateButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstimateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: customOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String fromCountry = _fromCountryController.text;
            String fromCity = _fromCityController.text;
            String toCountry = _toCountryController.text;
            String toCity = _toCityController.text;
            String shippingMethod = _tabController.index == 0
                ? 'Land'
                : _tabController.index == 1
                    ? 'Air'
                    : 'Sea';

            if (fromCountry.isEmpty ||
                fromCity.isEmpty ||
                toCountry.isEmpty ||
                toCity.isEmpty) {
              _showErrorDialog(
                  'Please select both the "From" and "To" country and city.');
              return;
            }

            if (fromCountry == toCountry && fromCity == toCity) {
              _showErrorDialog('Shipping within the same city is not allowed.');
              return;
            }

            if (shippingMethod == 'Land') {
              if (fromCountry != toCountry &&
                  !countries.contains(fromCountry) &&
                  !countries.contains(toCountry)) {
                _showErrorDialog(
                    'Land shipping is only allowed within the same country or between countries connected by land routes.');
                return;
              }
              if (fromCountry != toCountry &&
                  (!sameContinentCountries.containsKey(fromCountry) ||
                      !sameContinentCountries[fromCountry]!
                          .contains(toCountry))) {
                _showErrorDialog(
                    'Land shipping is not allowed for cross-continental routes.');
                return;
              }
            } else if (shippingMethod == 'Sea') {
              if (!portCities.contains(fromCity) ||
                  !portCities.contains(toCity)) {
                _showErrorDialog(
                    'Sea shipping is only allowed between cities with access to ports. Examples: Country A to Country B.');
                return;
              }
              if (fromCountry == toCountry) {
                _showErrorDialog(
                    'International shipping methods (Sea, Air) are not allowed within the same country.');
                return;
              }
            } else if (shippingMethod == 'Air') {
              if (fromCountry == toCountry &&
                  countryCityMap[fromCountry]!.contains(fromCity) &&
                  countryCityMap[toCountry]!.contains(toCity)) {
                _showErrorDialog(
                    'Air or Sea shipping is not allowed for short distances within the same country where land shipping is more practical.');
                return;
              }
            }

            if (_tabController.index == 2) {
              // Sea shipping
              if (_cbmController.text.isEmpty &&
                  (_lengthController.text.isEmpty ||
                      _breadthController.text.isEmpty ||
                      _heightController.text.isEmpty)) {
                _showErrorDialog(
                    'Please enter either the dimensions or the CBM for sea shipping.');
                return;
              }
            } else {
              // Land and Air shipping
              if (_lengthController.text.isEmpty ||
                  _breadthController.text.isEmpty ||
                  _heightController.text.isEmpty) {
                _showErrorDialog(
                    'Please enter the dimensions (LxBxH) for land and air shipping.');
                return;
              }
            }

            double shippingCost = calculateShippingCost();
            double? cbm = _tabController.index == 2
                ? double.tryParse(_cbmController.text)
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
                  weight: double.tryParse(_weightController.text) ?? 0.0,
                  goodsType: _selectedGoodsType,
                  length: double.tryParse(_lengthController.text) ?? 0.0,
                  width: double.tryParse(_breadthController.text) ?? 0.0,
                  height: double.tryParse(_heightController.text) ?? 0.0,
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

  void _showErrorDialog(String message) {
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
