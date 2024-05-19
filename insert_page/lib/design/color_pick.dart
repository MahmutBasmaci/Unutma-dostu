import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorButton extends StatefulWidget {
  const ColorButton({super.key});

  @override
  _ColorButtonState createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  Color _buttonColor = Colors.grey;

  void _changeColor() {
    Color selectedColor = const Color.fromARGB(255, 3, 0, 1);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Renk seçin'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _buttonColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                setState(() {
                  _buttonColor = selectedColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.0,
      height: 48.0,
      child: ElevatedButton(
        onPressed: _changeColor,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(48.0, 48.0),
          backgroundColor: _buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black87, width: 1),
          ),
        ),
        child: const Icon(Icons.colorize, color: Color(0xFFFFFFFF)),
      ),
    );
  }
}
