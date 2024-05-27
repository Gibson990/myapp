import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              'Item 1',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {
              // Add your item 1 logic here
            },
          ),
          ListTile(
            title: Text(
              'Item 2',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {
              // Add your item 2 logic here
            },
          ),
        ],
      ),
    );
  }
}
