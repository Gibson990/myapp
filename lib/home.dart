import 'package:flutter/material.dart';
import 'package:myapp/currently_orders.dart';
import 'package:myapp/search_box.dart';
import 'package:myapp/slide_view.dart';
import 'package:myapp/quick_actions.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).primaryColor,
                  // padding: const EdgeInsets.symmetric(vertical: 2.0),
                  // ignore: prefer_const_constructors
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: SearchBox(),                        
                      ),
                      // SizedBox(height: 4),
                      SlideView(),
                      // const SizedBox(height: 8),
                      QuickActions(),
                      //  SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: CurrentlyOrders(),
        ),
      ),
    );
  }
}