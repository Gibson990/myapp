import 'package:flutter/material.dart';

class OrderOption {
  final String title;
  final String subtitle;

  OrderOption({required this.title, required this.subtitle});
}

class OrderBottomSheet extends StatefulWidget {
  @override
  _OrderBottomSheetState createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  int _selectedOption = -1;

  final List<OrderOption> _options = [
    OrderOption(
      title: 'International Order',
      subtitle: 'Create international orders to import or export your \nproducts world wide',
    ),
    OrderOption(
      title: 'Local Pickup',
      subtitle: 'Fast and convenient shipping within your local area, \nAffordable rates for local shipments',
    ),
    OrderOption(
      title: 'Return Order',
      subtitle: 'Easy and streamlined return process, Flexible options for\nreturn shipping, including pickup and drop-off',
    ),
    OrderOption(
      title: 'Refund Order',
      subtitle: 'Quick and easy refunds for your customers Streamlined \nrefund process to save you time and effort',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select your Order Category:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < _options.length; i++)
              RadioListTile(
                title: Text(
                  _options[i].title,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  _options[i].subtitle,
                  style: TextStyle(
                    color: _selectedOption == i ? Theme.of(context).hintColor : Theme.of(context).hintColor,
                  ),
                ),
                activeColor: Theme.of(context).primaryColor,
                value: i,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: 342,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  if (_selectedOption != -1) {
                    // Handle the proceed action
                    Navigator.pop(context, _selectedOption);
                  }
                },
                child: const Text(
                  'Proceed',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
