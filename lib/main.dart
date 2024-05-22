import 'package:flutter/material.dart';
import 'package:myapp/bottom_navBar.dart';
import 'package:myapp/help.dart';
import 'package:myapp/home.dart';
import 'package:myapp/notification_Icon.dart';
import 'package:myapp/orders.dart';
import 'package:myapp/profile.dart';
import 'package:myapp/sideDrawer.dart';
import 'package:myapp/search_box.dart'; // Import the search box widget
import 'package:myapp/slide_view.dart'; // Import the slide view widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFF7F00), // Main color
        hintColor: Color(0xFF9F9E9D), // Accent color
        secondaryHeaderColor: Color(0xFFAC3438), // Secondary color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF7F00), // Set the background color of the app bar
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600, // Semibold
            color: Colors.white, // Text color
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Icon color
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

  static final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Orders(),
    Help(),
    Profile(),
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text('Your App Title'),
        actions: [
          NotificationIcon(),
        ],
      ),
      drawer: SideDrawer(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor, // Set the background color to primaryColor
            child: Column(
              children: const [
                SearchBox(), // Add the search box here
                SlideView(), // Add the slide view here
              ],
            ),
          ),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
