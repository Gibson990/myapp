import 'package:flutter/material.dart';
import 'package:myapp/update_profile_page.dart'; // Import the UpdateProfilePage

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          Container(
            height: 200, // Adjust the height as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/avatar.png'), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4, // Adjust the elevation as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Personal details',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdateProfilePage(),
                            ),
                          );
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildDetail(context, 'User name:', 'Faraji Tonge'),
                  _buildDetail(context, 'Email:', 'Farujohn@gmail.com'),
                  _buildDetail(context, 'Phone number:', '+255 6788 876 435'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
