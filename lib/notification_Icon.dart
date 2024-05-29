import 'package:flutter/material.dart';
import 'package:myapp/notification_Screen.dart';


class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NotificationScreen(),
          ),
        );
      },
    );
  }
}
