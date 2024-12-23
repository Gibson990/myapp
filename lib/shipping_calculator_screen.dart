import 'package:flutter/material.dart';
import 'package:myapp/shipping_option_card.dart';
import 'package:myapp/shipping_rate_estimate.dart';

class ShippingCalculatorScreen extends StatefulWidget {
  const ShippingCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<ShippingCalculatorScreen> createState() => _ShippingCalculatorScreenState();
}

class _ShippingCalculatorScreenState extends State<ShippingCalculatorScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _selectedGoodsType = 'Select';
  final _weightController = TextEditingController();
  final _lengthController = TextEditingController();
  final _breadthController = TextEditingController();
  final _heightController = TextEditingController();
  final _fromCountryController = TextEditingController();
  final _fromCityController = TextEditingController();
  final _toCountryController = TextEditingController();
  final _toCityController = TextEditingController();

  static const Color customOrange = Color(0xFFFF7F00);
  static const double borderRadius = 8.0;

  final List<String> _goodsTypes = [
    'Select',
    'Electronics',
    'Clothing',
    'Food',
    'Furniture',
    'Other',
  ];

  final List<String> _countries = [
    'China',
    'Tanzania',
    'India',
    'United States',
    'Germany',
    'Brazil',
    'Canada',
    'Kenya',
    'Australia',
    'South Africa'
  ];

  final List<String> _cities = [
    'Beijing',
    'Shanghai',
    'Mumbai',
    'New Delhi',
    'Dar es Salaam',
    'Nairobi',
    'Berlin',
    'Sao Paulo',
    'Toronto',
    'Cape Town'
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  double calculateShippingCost() {
    double baseRate = 2.5;
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double length = double.tryParse(_lengthController.text) ?? 0.0;
    double breadth = double.tryParse(_breadthController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;

    double volumetricWeight = (length * breadth * height) / 5000;
    double chargeableWeight = weight > volumetricWeight ? weight : volumetricWeight;

    return chargeableWeight * baseRate;
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
              _buildShippingOptions(screenWidth),
              SizedBox(height: spacingBetweenSections),
              _buildTabs(),
              SizedBox(height: spacingBetweenSections * 0.75),
              _buildGoodsAndWeightRow(padding),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
                child: const Text(
                  'Note: The minimum chargeable weight is 0.50kg',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: spacingBetweenSections * 0.75),
              _buildDimensionsSection(padding),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
                child: const Text(
                  'Note: Dimension value should be greater than 0.50 cm',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: spacingBetweenSections),
              _buildLocationSection(padding),
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

  Widget _buildShippingOptions(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ShippingOptionCard(
            title: 'By Land',
            cost: 'From \$2.5 per KG',
            weight: 'Up to 19,958lbs',
          ),
        ),
        SizedBox(width: screenWidth < 600 ? 8 : 12),
        Expanded(
          child: ShippingOptionCard(
            title: 'By Air',
            cost: 'From \$13 per KG',
            weight: 'Up to 9072 KG',
          ),
        ),
        SizedBox(width: screenWidth < 600 ? 8 : 12),
        Expanded(
          child: ShippingOptionCard(
            title: 'By Sea',
            cost: 'From \$2.5 per KG',
            weight: 'Up to ∞',
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(
          color: customOrange,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        tabs: const [
          Tab(text: 'Land'),
          Tab(text: 'Air'),
          Tab(text: 'Sea'),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget _buildGoodsAndWeightRow(double padding) {
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
      value: _selectedGoodsType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: customOrange),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      items: _goodsTypes.map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedGoodsType = newValue!;
        });
      },
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
      controller: _weightController,
      keyboardType: TextInputType.number,
      decoration: _buildInputDecoration('Weight (kg)').copyWith(suffixText: 'KG'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter weight';
        }
        return null;
      },
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: customOrange),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  Widget _buildDimensionsSection(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Package Dimensions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _lengthController,
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration('Length (cm)').copyWith(suffixText: 'CM'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _breadthController,
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration('Breadth (cm)').copyWith(suffixText: 'CM'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: _buildInputDecoration('Height (cm)').copyWith(suffixText: 'CM'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
      child: Row(
        children: [
          Expanded(
            child: _buildLocationColumn('From', _fromCountryController, _fromCityController),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLocationColumn('To', _toCountryController, _toCityController),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationColumn(String title, TextEditingController countryController, TextEditingController cityController) {
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

  Widget _buildLocationDropdowns(TextEditingController countryController, TextEditingController cityController) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: null,
          hint: const Text('Country'),
          items: _countries.map((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (String? newValue) {
            countryController.text = newValue ?? '';
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(borderRadius),
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const Divider(height: 0, color: Colors.grey),
        DropdownButtonFormField<String>(
          value: null,
          hint: const Text('City'),
          items: _cities.map((String city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: (String? newValue) {
            cityController.text = newValue ?? '';
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(borderRadius),
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
// Update the _buildEstimateButton() method
Widget _buildEstimateButton() {
  return SizedBox(  // Wrap with SizedBox to take full width
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
          double shippingCost = calculateShippingCost();
          // Navigate to the new screen instead of showing dialog
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShippingRateEstimateScreen(
                shippingCost: shippingCost,
                fromCountry: _fromCountryController.text,
                fromCity: _fromCityController.text,
                toCountry: _toCountryController.text,
                toCity: _toCityController.text,
                weight: double.tryParse(_weightController.text) ?? 0.0,
                goodsType: _selectedGoodsType, 
                length: 10, width: 30, height: 40,
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
 
  @override
  void dispose() {
    _tabController.dispose();
    _weightController.dispose();
    _lengthController.dispose();
    _breadthController.dispose();
    _heightController.dispose();
    _fromCountryController.dispose();
    _fromCityController.dispose();
    _toCountryController.dispose();
    _toCityController.dispose();
    super.dispose();
  }
}