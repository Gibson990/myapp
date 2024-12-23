import 'package:flutter/material.dart';
import 'package:myapp/tracking_card.dart';

class CurrentlyOrders extends StatefulWidget {
  const CurrentlyOrders({super.key});

  @override
  State<CurrentlyOrders> createState() => _CurrentlyOrdersState();
}

class _CurrentlyOrdersState extends State<CurrentlyOrders> {
  final List<Map<String, dynamic>> orders = [
    {'orderNumber': '102 2881 432', 'orderStatus': 'On the way', 'date': '2024-06-11', 'currentStep': 3, 'description': 'Order is on the way to your city.'},
    {'orderNumber': '102 2881 433', 'orderStatus': 'Ready to ship', 'date': '2024-06-10', 'currentStep': 2, 'description': 'Order is ready to be shipped.'},
    {'orderNumber': '102 2881 434', 'orderStatus': 'Pickup', 'date': '2024-06-09', 'currentStep': 1, 'description': 'Order is ready for pickup.'},
    {'orderNumber': '102 2881 435', 'orderStatus': 'Delivered', 'date': '2024-06-08', 'currentStep': 4, 'description': 'Order has been delivered.'},
    {'orderNumber': '102 2881 436', 'orderStatus': 'In your city', 'date': '2024-06-07', 'currentStep': 3, 'description': 'Order is in your city and will be delivered soon.'},
  ];

  bool showFloatingButton = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your order information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to all orders page
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      final scrollOffset = scrollNotification.metrics.pixels;
                      const cardHeight = 96.0; // Approximate card height
                      const showButtonThreshold = 3 * cardHeight;

                      // Show FAB if the user is at the top (scrollOffset == 0)
                      // or if the user has scrolled past 3 cards
                      if (scrollOffset == 0 || scrollOffset >= showButtonThreshold) {
                        if (!showFloatingButton) {
                          setState(() {
                            showFloatingButton = true;
                          });
                        }
                      } else if (scrollOffset < showButtonThreshold && showFloatingButton) {
                        setState(() {
                          showFloatingButton = false;
                        });
                      }
                    }
                    return true;
                  },
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TrackingCard(
                          orderNumber: order['orderNumber'],
                          orderStatus: order['orderStatus'],
                          date: order['date'],
                          currentStep: order['currentStep'],
                          description: order['description'],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showFloatingButton)
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 4,
                onPressed: () {
                  // Handle button action
                },
                shape: const CircleBorder(),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
