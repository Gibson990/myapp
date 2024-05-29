import 'package:flutter/material.dart';
import 'package:myapp/bottom_navBar.dart';
import 'package:myapp/help_page.dart';
import 'package:myapp/home.dart';
import 'package:myapp/notification_Icon.dart';
import 'package:myapp/orders_page.dart';
import 'package:myapp/profile_page.dart';
import 'package:myapp/quick_actions.dart';
import 'package:myapp/search_box.dart';
import 'package:myapp/side_drawer.dart';
import 'package:myapp/slide_view.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make status bar transparent
      statusBarIconBrightness: Brightness.light, // Make status bar icons white
      statusBarBrightness: Brightness.dark, // For iOS, to ensure contrast
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          systemOverlayStyle: SystemUiOverlayStyle.light, // Ensure white status bar icons
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            switch (index) {
              case 1:
                return const OrdersPage();
              case 2:
                return const HelpPage();
              case 3:
                return const ProfilePage();
              default:
                return const Home();
            }
          },
        ),
      );
    }
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
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text('Your App Title'),
        actions: const [
          NotificationIcon(),
        ],
      ),
      drawer: const SideDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: const Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Column(
                children: [
                  SearchBox(),
                  SlideView(),
                  QuickActions(),
                ],
              ),
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
