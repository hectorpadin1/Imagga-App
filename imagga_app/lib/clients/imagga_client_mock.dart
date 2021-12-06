import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'imagga_client.dart';
import 'models/face_model.dart';

class ImaggaClientMock implements ImaggaClient {
  ImaggaClientMock({
    this.slow = false,
    this.error = false
  }) : assert(slow || error);

  final bool slow;
  final bool error;

  final ImaggaClient realClient = ImaggaClient();

  Future<List<Face>> loadImageDataURL(File image) async {
    if (slow) {
      Random rng = Random();
      await Future.delayed(
        Duration(seconds: rng.nextInt(10)),
            () => true,
      );
    }
    if (error) {
      await Future.delayed(
        Duration(seconds: 2),
            () => true,
      );
      throw 'IOError';
    }
    else {
      return realClient.loadImageDataURL(image);
    }
  }
}
