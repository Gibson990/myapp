import 'package:flutter/material.dart';
import 'package:myapp/order_tracking/tracking_card.dart';

import '../order_tracking/live_order_tracking_map.dart';
import 'tracking_order_status_card.dart';

class TrackingScreen extends StatelessWidget {
  final String awbNumber;

  TrackingScreen({super.key, required this.awbNumber});

  final Map<String, dynamic> sampleOrder = {
    'orderNumber': '102 2881 432',
    'orderStatus': 'On the way',
    'date': '2024-06-11',
    'currentStep': 3,
    'description': 'Order is on the way to your city.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tracking Shipment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor:
            Theme.of(context).primaryColor, // Use theme's primary color
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.map_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LiveOrderTrackingMap(
                      isInternational: false,
                      transportMode: 'land',
                    )),
          );
        },
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 6, // Increased elevation for more drop shadow
                  shadowColor:
                      Colors.black.withOpacity(0.3), // Darker shadow color
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tracking ID:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              awbNumber,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'From',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Beijing CN',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Transit',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Customer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Faraji Tonge',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'To',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'DSM TZ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '100kg',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey[300]!,
                          Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.9),
                          offset: const Offset(-4, -4),
                          blurRadius: 8,
                        ),
                        BoxShadow(
                          color: Colors.grey[400]!.withOpacity(0.5),
                          offset: const Offset(4, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Container(
                      height:
                          70, // Increased height to accommodate larger avatars
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xFF00DDC5),
                            backgroundImage:
                                AssetImage('assets/images/help_desk.png'),
                            radius: 25, // Increased radius
                          ),
                          const SizedBox(
                              width: 16), // Added space between avatar and text
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Help Desk',
                                  style: TextStyle(
                                    fontSize: 18, // Increased font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Customer Service',
                                  style: TextStyle(
                                    fontSize: 16, // Increased font size
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 25, // Increased radius
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 28, // Increased icon size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TrackingCard(
                  orderNumber: sampleOrder['orderNumber'],
                  orderStatus: sampleOrder['orderStatus'],
                  date: sampleOrder['date'],
                  currentStep: sampleOrder['currentStep'],
                  description: sampleOrder['description'],
                ),
              ),
              const TrackingOrderStatusCard(
                trackingId: 'J2AQ92w89',
                customerName: 'Faraji Tonge',
                fromLocation: 'Beijing CN',
                toLocation: 'DSM TZ',
                status: 'In Transit',
                weight: 100.0,
                timeline: [
                  {
                    'location': 'Transit',
                    'date': '20 Feb, 23',
                    'time': '06:00',
                    'status': 'Completed'
                  },
                  {
                    'location': 'Ready for Shipping (Beijing)',
                    'date': '23 Apr, 23',
                    'time': '08:02',
                    'status': 'Completed'
                  },
                  {
                    'location': 'On the Way (Ethiopia)',
                    'date': '24 Apr, 23',
                    'time': '09:04',
                    'status': 'Pending'
                  },
                  {
                    'location': 'In Your City (DSM TZ)',
                    'date': '26 Apr, 23',
                    'time': '09:05',
                    'status': 'Pending'
                  },
                  {
                    'location': 'Ready for Delivery (DSM TZ)',
                    'date': '26 Apr, 23',
                    'time': '12:04',
                    'status': 'Pending'
                  },
                ],
              ),

              // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }
}
