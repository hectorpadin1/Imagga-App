import 'dart:io';
import 'package:flutter/material.dart';

import 'clients/imagga_client.dart';

class Data with ChangeNotifier {
  int breakpoint = 600;
  File _image;
  final ImaggaClient client = ImaggaClient();

  File get image => _image;

  set image(File value) {
    _image = value;
    notifyListeners();
  }
}