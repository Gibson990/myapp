import 'package:flutter/material.dart';
import 'package:myapp/tracking_card.dart';

class CurrentlyOrders extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'orderNumber': '102 2881 432',
      'orderStatus': 'On the way',
      'date': '2024-06-11',
      'currentStep': 3,
      'description': 'Order is on the way to your city.',
    },
    {
      'orderNumber': '102 2881 433',
      'orderStatus': 'Ready to ship',
      'date': '2024-06-10',
      'currentStep': 2,
      'description': 'Order is ready to be shipped.',
    },
    {
      'orderNumber': '102 2881 434',
      'orderStatus': 'Pickup',
      'date': '2024-06-09',
      'currentStep': 1,
      'description': 'Order is ready for pickup.',
    },
    {
      'orderNumber': '102 2881 435',
      'orderStatus': 'Delivered',
      'date': '2024-06-08',
      'currentStep': 4,
      'description': 'Order has been delivered.',
    },
    {
      'orderNumber': '102 2881 436',
      'orderStatus': 'In your city',
      'date': '2024-06-07',
      'currentStep': 3,
      'description': 'Order is in your city and will be delivered soon.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your order information',
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to all orders page
                          },
                          child: Text(
                            'View All',
                            style: TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (orders.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, color: Theme.of(context).hintColor, size: 48),
                      SizedBox(height: 8),
                      Text('No orders', style: TextStyle(color: Theme.of(context).hintColor)),
                    ],
                  ),
                )
              else
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
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
              SizedBox(height: 80.0), // Spacer for floating button
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: Center(
            child: IgnorePointer(
              child: Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  onPressed: () {
                    // Navigate to all orders page
                  },
                  shape: CircleBorder(),
                  child: Icon(Icons.keyboard_arrow_down,size: 48.0, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
