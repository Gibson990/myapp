import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const QuickActionButton({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 80,
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 2),
          Wrap(
            alignment: WrapAlignment.center,
            children: text.split(' ').map((word) {
              return Text(
                word,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
