import 'package:flutter/material.dart';
import 'package:myapp/search_box.dart';
import 'package:myapp/slide_view.dart';
import 'package:myapp/quick_actions.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: SingleChildScrollView(
        child: Column(
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
            // Add your additional content here
          ],
        ),
      ),
    );
  }
}
