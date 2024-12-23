import 'package:flutter/material.dart';
import 'package:test_screens/widgets/shipping_option_card.dart';

class ShippingOptions extends StatelessWidget {
  final double screenWidth;

  const ShippingOptions({Key? key, required this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
