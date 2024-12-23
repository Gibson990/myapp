import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final Function() onPressed;

  const FloatingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: IgnorePointer(
        child: Center(
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0.0,
              onPressed: onPressed,
              child: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor),
            ),
          ),
        ),
      ),
    );
  }
}
