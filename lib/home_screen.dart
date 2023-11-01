import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_filter/filter.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:image_filter/second_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _globalKey = GlobalKey();


  void convertWidgetToImage() async {
    // RenderRepaintBoundary repaintBoundary = _globalKey.currentContext.findRenderObject();
    RenderRepaintBoundary repaintBoundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
    // ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
    ByteData? byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);

    Uint8List uint8list = byteData!.buffer.asUint8List();
    Navigator.of(_globalKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => SecondScreen(
          imageData: uint8list,
        )));
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Image Filter',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: convertWidgetToImage,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Center(
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width,
              maxHeight: size.width,
            ),
            child: PageView.builder(
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return ColorFiltered(
                    colorFilter: ColorFilter.matrix(filters[index].matrixValues),
                    child: Image.asset(
                      'assets/img/my_profile.jpg',
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
