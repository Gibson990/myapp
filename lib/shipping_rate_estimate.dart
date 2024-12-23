import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home.dart';

class ShippingRateEstimateScreen extends StatelessWidget {
  final double shippingCost;
  final String fromCountry;
  final String fromCity;
  final String toCountry;
  final String toCity;
  final double weight;
  final String goodsType;
  final double length;
  final double width;
  final double height;

  const ShippingRateEstimateScreen({
    Key? key,
    required this.shippingCost,
    required this.fromCountry,
    required this.fromCity,
    required this.toCountry,
    required this.toCity,
    required this.weight,
    required this.goodsType,
    required this.length,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate estimated delivery date (3 business days from now)
    final deliveryDate = DateTime.now().add(const Duration(days: 3));
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7F00),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Rate Estimate',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          _buildCostSection(deliveryDate),
          const SizedBox(height: 16),
          _buildLocationSection(),
          const SizedBox(height: 16),
          _buildPackageSection(),
        ],
      ),
    );
  }

  Widget _buildCostSection(DateTime deliveryDate) {
    return Container(
      color: const Color(0xFFFF7F00),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Estimated Shipping Cost',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                'Tsh ${NumberFormat('#,###').format(shippingCost)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shipping Method',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Text(
                'Air ways',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery Day',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                DateFormat('E, MMM d').format(deliveryDate),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Rate shown may be different than actual charges for your shipment. Difference may occur based on actual weight, dimensions or other factors',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FROM',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$fromCity $fromCountry',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'TO',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$toCity $toCountry',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PACKAGE INFORMATION',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'weight: ${weight.toStringAsFixed(1)} kg',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Dimensions: ${length.toStringAsFixed(0)} cm x ${width.toStringAsFixed(0)} cm x ${height.toStringAsFixed(0)} cm',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}