import 'package:flutter/material.dart';

Widget buildErrorMessage(String? errorText) {
  if (errorText == null) return SizedBox.shrink();
  return Container(
    margin: EdgeInsets.only(top: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.red.shade100,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.red.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            errorText,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
