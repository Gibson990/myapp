import 'package:flutter/material.dart';

class OrderOption {
  final String title;
  final String subtitle;

  OrderOption({required this.title, required this.subtitle});
}

class OrderBottomSheet extends StatefulWidget {
  const OrderBottomSheet({super.key});

  @override
  _OrderBottomSheetState createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  final List<OrderOption> _options = [
    OrderOption(
      title: 'International Order',
      subtitle: 'Create international orders to import or export your products worldwide.',
    ),
    OrderOption(
      title: 'Local Pickup',
      subtitle: 'Fast and convenient shipping within your local area.',
    ),
    OrderOption(
      title: 'Return Order',
      subtitle: 'Easy and streamlined return process for your convenience.',
    ),
    OrderOption(
      title: 'Refund Order',
      subtitle: 'Quick and easy refunds for your customers.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select your Order Category:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            for (int i = 0; i < _options.length; i++)
              ListTile(
                title: Text(
                  _options[i].title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Text(
                  _options[i].subtitle,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 12.0,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, _options[i]); // Return selected option
                },
              ),
          ],
        ),
      ),
    );
  }
}
