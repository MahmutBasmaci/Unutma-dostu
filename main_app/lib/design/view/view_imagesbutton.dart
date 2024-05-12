import 'package:flutter/material.dart';

import '../textfont.dart';

class Imagesbutton extends StatelessWidget {
  final String text;
  final String path;

  const Imagesbutton(this.text, this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showImage(context, path, text);
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black87, width: 3))),
      child: Textfont(text, 20),
    );
  }

  void _showImage(BuildContext context, String imagePath, String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(text),
        content: Image.asset(imagePath), // Use the imagePath parameter
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('close'),
          ),
        ],
      ),
    );
  }
}