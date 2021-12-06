import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:imagga_app/clients/models/face_model.dart';

import '../constants.dart';

class ImaggaClient {
  const ImaggaClient();

  Future<List<Face>> loadImageDataURL(File image) async {
    final response = await post(
        '${kAPIEndPoint}',
        headers: {HttpHeaders.authorizationHeader: '${KAutorization}'},
        body: {
          "image_base64": base64Encode(File(image.path).readAsBytesSync()),
          //  "return_face_id": "1",
          "return_face_attributes": "1",
        });

    if (response.statusCode != 200) {
      throw 'Error getting IP address:\nHttp status ${response.statusCode}';
    }

    final jsonData = jsonDecode(response.body);
    List<Face> faces = [];

    for (var f in jsonData['result']['faces']) {
      Face face = Face.fromJsonList(f);
      faces.add(face);
    }

    return faces;
  }
}
