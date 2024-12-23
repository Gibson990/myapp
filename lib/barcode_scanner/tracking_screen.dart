import 'package:flutter/material.dart';

class TrackingScreen extends StatelessWidget {
  final String awbNumber;

  const TrackingScreen({Key? key, required this.awbNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Details'),
      ),
      body: Center(
        child: Text('Tracking details for AWB: $awbNumber'),
      ),
    );
  }
}