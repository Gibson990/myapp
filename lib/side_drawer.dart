import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  bool _notificationSwitchValue = true;
  bool _faceIdSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Set borderRadius to zero for no rounded corners
      ),
      elevation: 0, // No shadow
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 46,
                    backgroundImage: AssetImage('assets/images/avatar.png'), // Replace with your asset
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Navigator.of(context).pushReplacementNamed('/home'),
          ),
          _createDrawerItem(
            icon: Icons.account_circle,
            text: 'Profile',
            onTap: () => Navigator.of(context).pushReplacementNamed('/profile'),
          ),
          _createDrawerItemWithSwitch(
            icon: Icons.notifications,
            text: 'Notification',
            switchValue: _notificationSwitchValue,
            onSwitchChanged: (bool value) {
              setState(() {
                _notificationSwitchValue = value;
              });
            },
            activeColor: primaryColor,
          ),
          _createDrawerItemWithSwitch(
            icon: Icons.face,
            text: 'Enable face ID',
            switchValue: _faceIdSwitchValue,
            onSwitchChanged: (bool value) {
              setState(() {
                _faceIdSwitchValue = value;
              });
            },
            activeColor: primaryColor,
          ),
          _createDrawerItem(
            icon: Icons.history,
            text: 'Order History',
            onTap: () => Navigator.of(context).pushReplacementNamed('/orderHistory'),
          ),
          _createDrawerItem(
            icon: Icons.help,
            text: 'Help/FAQ',
            onTap: () => Navigator.of(context).pushReplacementNamed('/helpFAQ'),
          ),
          _createDrawerItem(
            icon: Icons.info,
            text: 'About',
            onTap: () => Navigator.of(context).pushReplacementNamed('/about'),
          ),
          _createDrawerItem(
            icon: Icons.contact_mail,
            text: 'Contact Us',
            onTap: () => Navigator.of(context).pushReplacementNamed('/contactUs'),
          ),
          const SizedBox(height: 40), // Spacing below "Contact Us"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OutlinedButton(
              onPressed: () {
                // Handle logout logic
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Set borderRadius to zero for no rounded corners
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 40),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createDrawerItemWithSwitch(
      {required IconData icon,
      required String text,
      required bool switchValue,
      required ValueChanged<bool> onSwitchChanged,
      required Color activeColor}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.black),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Switch(
            value: switchValue,
            onChanged: onSwitchChanged,
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }
}
