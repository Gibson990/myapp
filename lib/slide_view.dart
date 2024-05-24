import 'package:flutter/material.dart';

class SlideView extends StatefulWidget {
  const SlideView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SlideViewState createState() => _SlideViewState();
}

class _SlideViewState extends State<SlideView> {
  int _currentIndex = 0;
  // ignore: prefer_final_fields
  PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onIndicatorTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          width: double.infinity,
          height: 200.0, // Adjusted height to accommodate indicators
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: PageView(
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
                      buttonText:  'Book Now',
                      image: 'assets/slideview/local_delivery_image.png',
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8.0,
                top: 116.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () {
                        _onIndicatorTap(index);
                      },
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          border: _currentIndex == index
                              ? Border.all(color: Colors.white, width: 2.0)
                              : null,
                        ),
                      ),
                    );
                  }),
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
    return Center(
      child: Stack(
        children: [
          Container(
            width: 380.0, // Increased card width
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), // Rounded corners set to 4px
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0), // Apply rounded corners to the image
              child: Image.asset(
                image,
                width: 380.0,
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 380.0,
            height: 180.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.18), // Overlay with 18% opacity
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 14, // Increased font size to 14
                    color: Colors.white, // Text color
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 120.0, // Button width
                  height: 36.0, // Button height
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      backgroundColor: const Color(0xFFFF7F00),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 14, // Text size
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
