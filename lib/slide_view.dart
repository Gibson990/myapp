import 'package:flutter/material.dart';

class SlideView extends StatefulWidget {
  const SlideView({Key? key}) : super(key: key);

  @override
  _SlideViewState createState() => _SlideViewState();
}

class _SlideViewState extends State<SlideView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0),
          width: double.infinity,
          height: 180.0,
          color: Color(0xFFFF7F00),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SlideItem(
                title: 'Air Cargo Shipping',
                body:
                    'Get your goods to their destination quickly and efficiently with our air cargo shipping service.',
                buttonText: 'Get Started',
                image: 'assets/slideview/air_cargo_image.png',
              ),
              SlideItem(
                title: 'Sea Freight Shipping',
                body:
                    'Move your goods by sea and save money with our reliable and cost-effective sea freight shipping service.',
                buttonText: 'Learn More',
                image: 'assets/slideview/sea_freight_image.png',
              ),
              SlideItem(
                title: 'Local Delivery Services',
                body:
                    'Need to get your goods delivered locally? Look no further than our reliable and affordable local delivery service.',
                buttonText: 'Book Now',
                image: 'assets/slideview/local_delivery_image.png',
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.white : Colors.white.withOpacity(0.5),
                border: _currentIndex == index
                    ? Border.all(color: Colors.white, width: 2.0)
                    : null,
              ),
            );
          }),
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          Image.asset(
            image,
            width: 320.0,
            height: 180.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 320.0,
            height: 180.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.18), // Overlay with 18% opacity
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              height: 100, // Set a fixed height or use Expanded to fit the content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    body,
                    style: TextStyle(
                      fontSize: 14, // Increased font size to 14
                      color: Colors.white, // Text color
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 120.0, // Button width
                    height: 36.0, // Button height
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        backgroundColor: Color(0xFFFF7F00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 14, // Text size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
