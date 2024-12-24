import 'package:flutter/material.dart';

class SlideView extends StatefulWidget {
  const SlideView({super.key});

  @override
  _SlideViewState createState() => _SlideViewState();
}

class _SlideViewState extends State<SlideView> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onIndicatorTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          width: double.infinity,
          height: isLargeScreen ? 220.0 : 180.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: const [
                  SlideItem(
                    title: 'Air Cargo Shipping',
                    body: 'Get your goods to their destination quickly and efficiently with our air cargo shipping service.',
                    buttonText: 'Get Started',
                    image: 'assets/slideview/air_cargo_image.png',
                  ),
                  SlideItem(
                    title: 'Sea Freight Shipping',
                    body: 'Move your goods by sea and save money with our reliable and cost-effective sea freight shipping service.',
                    buttonText: 'Learn More',
                    image: 'assets/slideview/sea_freight_image.png',
                  ),
                  SlideItem(
                    title: 'Local Delivery Services',
                    body: 'Need to get your goods delivered locally? Look no further than our reliable and affordable local delivery service.',
                    buttonText: 'Book Now',
                    image: 'assets/slideview/local_delivery_image.png',
                  ),
                ],
              ),
              Positioned(
                bottom: 8.0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return GestureDetector(
                          onTap: () => _onIndicatorTap(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentIndex == index ? 12.0 : 10.0,
                            height: _currentIndex == index ? 12.0 : 10.0,
                            margin: const EdgeInsets.symmetric(horizontal: 6.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              border: Border.all(
                                color: Colors.white,
                                width: _currentIndex == index ? 2.0 : 1.0,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SlideItem extends StatelessWidget {
  final String title;
  final String body;
  final String buttonText;
  final String image;

  const SlideItem({
    required this.title,
    required this.body,
    required this.buttonText,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                image,
                width: double.infinity,
                height: isLargeScreen ? 220.0 : 180.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Positioned(
              bottom: 24.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: 100.0,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        backgroundColor: const Color(0xFFFF7F00),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
