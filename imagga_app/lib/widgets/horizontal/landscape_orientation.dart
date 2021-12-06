import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imagga_app/provider.dart';
import 'package:imagga_app/widgets/menu.dart';
import 'package:imagga_app/widgets/vertical/view_response.dart';
import 'package:imagga_app/widgets/horizontal/view_response_horizontal.dart';
import 'package:provider/provider.dart';

import 'body_horizontal.dart';

class LandScapeOrientation extends StatelessWidget {
  final ValueNotifier<File> _imageSelected = ValueNotifier<File>(null);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Data>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: Text('Imagga App'),
        ),
        drawer: Menu(),
        body: Row(
          children: <Widget> [
            Flexible(
                child: Material(
                  elevation: 4.0,
                  child: BodyLandscape( onImageSelected: () {_imageSelected.value = provider.image;},),
                ),
            ),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: _imageSelected,
                builder: (BuildContext context, File image, Widget child) {
                  return image == null ?
                    Material(
                      elevation: 4.0,
                      child: Center(
                          child: Text(
                            'Please select\na photo to scan',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          )
                      ),
                    ) : Material(
                      elevation: 4.0,
                      child: ViewResponseLandsCape(),
                    );
                }
              ),
            ),
          ],
        ),
    );
  }
}
