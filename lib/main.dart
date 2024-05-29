import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/bottom_nav_bar.dart';
import 'package:myapp/help_page.dart';
import 'package:myapp/home.dart';
import 'package:myapp/notification_Icon.dart';
import 'package:myapp/orders_page.dart';
import 'package:myapp/profile_page.dart';
import 'package:myapp/side_drawer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFFF7F00),
        hintColor: const Color(0xFF9F9E9D),
        secondaryHeaderColor: const Color(0xFFAC3438),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF7F00),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'Home',
    'Orders',
    'Help',
    'Profile',
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const OrdersPage(),
    const HelpPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(_titles[_selectedIndex]), // Dynamic title
        actions: const [
          NotificationIcon(),
        ],
      ),
      drawer: const SideDrawer(), // Drawer set here
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
