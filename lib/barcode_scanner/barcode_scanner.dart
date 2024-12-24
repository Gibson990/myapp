import 'package:flutter/material.dart';
import 'package:myapp/barcode_scanner/tracking_screen.dart';

class BarcodeScanner extends StatefulWidget {
  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  bool isTorchOn = false;
  final TextEditingController _awbController = TextEditingController();

  void _proceed() {
    // Navigate to the TrackingScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrackingScreen(awbNumber: _awbController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Barcode Scanner',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Container(color: Colors.black, height: 250), // Reduced height
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 120, // Reduced height
                        child: Stack(
                          children: [
                            _buildScannerCorner(Alignment.topLeft, true, true),
                            _buildScannerCorner(
                                Alignment.topRight, false, true),
                            _buildScannerCorner(
                                Alignment.bottomLeft, true, false),
                            _buildScannerCorner(
                                Alignment.bottomRight, false, false),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Point your camera at a barcode',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 32, // Moved up a bit more
                  child: IconButton(
                    icon: Icon(
                      isTorchOn ? Icons.flashlight_on : Icons.flashlight_off,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    onPressed: () => setState(() => isTorchOn = !isTorchOn),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoText(
                    '1',
                    'You can scan multiple Shipping Labels. All scanned AWBs will be listed below. Click on any AWB to view Order details.',
                  ),
                  SizedBox(height: 8),
                  _buildInfoText(
                    '2',
                    'Packages being picked up from the same Pickup Address & being sent through the same Carrier Company will be added to the same Manifest post generating manifest.',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Generate Manifest(s) for AWBs:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _awbController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter AWB Number',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onSubmitted: (value) => _proceed(),
                  ),
                  SizedBox(height: 32), // Increased spacing
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _proceed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(2), // Reduced corner radius
                        ),
                      ),
                      child: Text('Proceed',
                          style: TextStyle(color: Colors.white)),
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

  // Helper methods remain the same
  Widget _buildScannerCorner(Alignment alignment, bool isLeft, bool isTop) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border(
            left: isLeft
                ? BorderSide(
                    color: Colors.white.withOpacity(0.7),
                    width: 3) // Thicker border
                : BorderSide.none,
            top: isTop
                ? BorderSide(
                    color: Colors.white.withOpacity(0.7),
                    width: 3) // Thicker border
                : BorderSide.none,
            right: !isLeft
                ? BorderSide(
                    color: Colors.white.withOpacity(0.7),
                    width: 3) // Thicker border
                : BorderSide.none,
            bottom: !isTop
                ? BorderSide(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.7),
                    width: 3) // Thicker border
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$number. ', style: TextStyle(color: Colors.grey[600])),
        Expanded(
          child: Text(text, style: TextStyle(color: Colors.grey[600])),
        ),
      ],
    );
  }
}
