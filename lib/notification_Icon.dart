import 'package:flutter/material.dart';
import 'package:myapp/notification_Screen.dart';


class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.notifications),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NotificationScreen(),
          ),
        );
      },
    );
  }
}
