import 'package:flutter/material.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/avatar.png'), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: IconButton(
                    onPressed: () {
                      // Implement camera functionality
                    },
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildTextInput(context, 'User name', 'Enter your username'),
          const SizedBox(height: 8),
          _buildTextInput(context, 'Email', 'Enter your email id'),
          const SizedBox(height: 8),
          _buildPhoneNumberInput(context),
          const SizedBox(height: 16),
          SizedBox(
            width: 320,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                // Implement update functionality
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ), backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInput(BuildContext context, String label, String hintText) {
    return SizedBox(
      width: 320,
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 40,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).hintColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonFormField(
                value: '+255', // Default value
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  border: InputBorder.none,
                ),
                items: const [
                  DropdownMenuItem(
                    value: '+1',
                    child: Text('+1'),
                  ),
                  DropdownMenuItem(
                    value: '+91',
                    child: Text('+91'),
                  ),
                  DropdownMenuItem(
                    value: '+44',
                    child: Text('+44'),
                  ),
                  DropdownMenuItem(
                    value: '+255',
                    child: Text('+255'),
                  ),
                ],
                onChanged: (value) {
                  // Handle selected country code
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).hintColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
