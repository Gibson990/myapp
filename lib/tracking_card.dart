import 'package:flutter/material.dart';

class TrackingCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String date;
  final int currentStep;
  final String description;

  const TrackingCard({
    super.key,
    required this.orderNumber,
    required this.orderStatus,
    required this.date,
    required this.currentStep,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final isSmallDevice = deviceWidth < 375; // Adjust this threshold as needed

    return Center(
      child: Container(
        width: deviceWidth * 0.94,
        padding: EdgeInsets.all(isSmallDevice ? 10 : 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: isSmallDevice
            ? _buildCompactLayout(context)
            : _buildFullLayout(context),
      ),
    );
  }

  Widget _buildCompactLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number: $orderNumber',
                style: TextStyle(
                    fontSize: 10, color: Theme.of(context).hintColor)),
            Text(date,
                style: const TextStyle(fontSize: 10, color: Colors.orange)),
          ],
        ),
        const SizedBox(height: 10),
        Text('Order Status: $orderStatus',
            style: const TextStyle(fontSize: 10, color: Colors.orange)),
        const SizedBox(height: 10),
        CompactProgressBar(currentStep: currentStep),
      ],
    );
  }

  Widget _buildFullLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Number: $orderNumber',
            style: TextStyle(color: Theme.of(context).hintColor)),
        Text('Order Status: $orderStatus',
            style: const TextStyle(color: Colors.orange)),
        Text(date, style: const TextStyle(color: Colors.orange)),
        const SizedBox(height: 16),
        ProgressBar(currentStep: currentStep),
        const SizedBox(height: 16),
        Text(description),
      ],
    );
  }
}

class CompactProgressBar extends StatelessWidget {
  final int currentStep;
  const CompactProgressBar({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 1; i <= 4; i++)
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: currentStep >= i ? Colors.orange : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  final int currentStep;
  const ProgressBar({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressNode(
            isCompleted: currentStep >= 1,
            label: 'Pickup',
            isActive: currentStep == 1),
        Expanded(child: ProgressLine(isCompleted: currentStep >= 2)),
        ProgressNode(
            isCompleted: currentStep >= 2,
            label: 'Ready to ship',
            isActive: currentStep == 2),
        Expanded(child: ProgressLine(isCompleted: currentStep >= 3)),
        ProgressNode(
            isCompleted: currentStep >= 3,
            label: 'On the way',
            isActive: currentStep == 3),
        Expanded(child: ProgressLine(isCompleted: currentStep >= 4)),
        ProgressNode(
            isCompleted: currentStep >= 4,
            label: 'In your city',
            isActive: currentStep == 4),
      ],
    );
  }
}

class ProgressNode extends StatelessWidget {
  final bool isCompleted;
  final bool isActive;
  final String label;

  const ProgressNode({
    super.key,
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
              const Icon(Icons.local_shipping, color: Colors.white, size: 10),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

class ProgressLine extends StatelessWidget {
  final bool isCompleted;

  const ProgressLine({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LinePainter(isCompleted: isCompleted),
      child: const SizedBox(
        height: 16,
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
      ..strokeWidth = 2;

    double centerY = size.height / 2 - 8;

    if (isCompleted) {
      canvas.drawLine(
          Offset(-8, centerY), Offset(size.width + 8, centerY), paint);
    } else {
      const dashWidth = 5.0;
      const dashSpace = 3.0;
      double startX = -8;
      while (startX < size.width + 8) {
        canvas.drawLine(Offset(startX, centerY),
            Offset(startX + dashWidth, centerY), paint);
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Example usage in a ListView
class TrackingCardList extends StatelessWidget {
  final List<TrackingCardData> trackingCards;

  const TrackingCardList({super.key, required this.trackingCards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trackingCards.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: MediaQuery.of(context).size.width < 375
              ? 120
              : 178, // Adjust these values as needed
          child: TrackingCard(
            orderNumber: trackingCards[index].orderNumber,
            orderStatus: trackingCards[index].orderStatus,
            date: trackingCards[index].date,
            currentStep: trackingCards[index].currentStep,
            description: trackingCards[index].description,
          ),
        );
      },
    );
  }
}

// Data model for TrackingCard
class TrackingCardData {
  final String orderNumber;
  final String orderStatus;
  final String date;
  final int currentStep;
  final String description;

  TrackingCardData({
    required this.orderNumber,
    required this.orderStatus,
    required this.date,
    required this.currentStep,
    required this.description,
  });
}
