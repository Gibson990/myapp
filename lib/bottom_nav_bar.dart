import 'package:flutter/material.dart';
import 'package:myapp/help_page.dart';
import 'package:myapp/profile_page.dart'; // Import your ProfilePage here

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Help',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).hintColor,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 2: // Profile
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(), // Navigate to ProfilePage
              ),
            );
            break;
          case 3: // Help
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HelpPage(),
              ),
            );
            break;
          default:
            onTap(index);
        }
      },
    );
  }
}
