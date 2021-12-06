import 'package:flutter/material.dart';
import 'package:imagga_app/widgets/vertical/body_vertical.dart';
import 'image_view_screen.dart';
import '../menu.dart';

class VerticalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagga App'),
      ),
      drawer: Menu(),
      body: Body(
          onImageSelected: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ImageViewScreen();
                },
              ),
            );
          }
      ),
    );
  }
}