import 'package:flutter/material.dart';

class NoTopUpAvailableWidget extends StatelessWidget {
  const NoTopUpAvailableWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),
      message,
      textAlign: TextAlign.center,
    );
  }
}
