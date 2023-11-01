import 'dart:typed_data';

import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final Uint8List imageData;

  const SecondScreen({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: size.width,
            maxHeight: size.width,
          ),
          child: Image.memory(
            imageData,
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
