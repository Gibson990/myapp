import 'package:flutter/material.dart';

class TrackingCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String date;
  final int currentStep;
  final String description;

  TrackingCard({
    required this.orderNumber,
    required this.orderStatus,
    required this.date,
    required this.currentStep,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: deviceWidth * 0.9, // 90% of the device width
        height: 190, // Increased height for description below progress bar
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Number: $orderNumber', style: TextStyle(color: Theme.of(context).hintColor)),
            Text('Order Status: $orderStatus', style: TextStyle(color: Colors.orange)),
            Text(date, style: TextStyle(color: Colors.orange)),
            SizedBox(height: 16),
            ProgressBar(currentStep: currentStep),
            SizedBox(height: 16),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final int currentStep;
  ProgressBar({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressNode(isCompleted: currentStep >= 1, label: 'Pickup', isActive: currentStep == 1),
        Expanded(child: ProgressLine(isCompleted: currentStep >= 2)),
        ProgressNode(isCompleted: currentStep >= 2, label: 'Ready to ship', isActive: currentStep == 2),
        Expanded(child: ProgressLine(isCompleted: currentStep >= 3)),
        ProgressNode(isCompleted: currentStep >= 3, label: 'On the way', isActive: currentStep == 3),
        Expanded(child: ProgressLine(isCompleted: currentStep >= 4)),
        ProgressNode(isCompleted: currentStep >= 4, label: 'In your city', isActive: currentStep == 4),
      ],
    );
  }
}

class ProgressNode extends StatelessWidget {
  final bool isCompleted;
  final bool isActive;
  final String label;

  ProgressNode({
    required this.isCompleted,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.orange : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            if (isActive)
              Icon(Icons.local_shipping, color: Colors.white, size: 10),
          ],
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}

class ProgressLine extends StatelessWidget {
  final bool isCompleted;

  ProgressLine({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LinePainter(isCompleted: isCompleted),
      child: SizedBox(
        height: 24,
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final bool isCompleted;

  _LinePainter({required this.isCompleted});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isCompleted ? Colors.orange : Colors.grey
      ..strokeWidth = 1.8;

    double centerY = size.height / 2 - 6; // Adjusting centerY to move the line up

    if (isCompleted) {
      canvas.drawLine(Offset(0, centerY), Offset(size.width, centerY), paint);
    } else {
      const dashWidth = 5.0;
      const dashSpace = 3.0;
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(Offset(startX, centerY), Offset(startX + dashWidth, centerY), paint);
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
