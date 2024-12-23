import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final TabController tabController;

  const Tabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(
          color: const Color(0xFFFF7F00),
          borderRadius: BorderRadius.circular(8.0),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: const [
          Tab(text: 'Land'),
          Tab(text: 'Air'),
          Tab(text: 'Sea'),
        ],
        controller: tabController,
      ),
    );
  }
}
