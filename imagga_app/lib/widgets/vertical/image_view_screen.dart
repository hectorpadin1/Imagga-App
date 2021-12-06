import 'package:flutter/material.dart';

import 'package:imagga_app/widgets/vertical/view_response.dart';

class ImageViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analyzer'),
      ),
      body: ViewResponse(),
    );
  }
}