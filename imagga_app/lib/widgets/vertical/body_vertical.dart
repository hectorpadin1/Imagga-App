import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagga_app/constants.dart';
import 'package:imagga_app/provider.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final void Function() onImageSelected;

  Body({this.onImageSelected}) : super();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final picker = ImagePicker();

  Future _openGallery(BuildContext context, provider) async {
    //use pickImage if something goes wrong or have a bug while opening camera/gallery
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    provider.image = File(pickedFile.path);
    this.setState(() {
      widget.onImageSelected();
    });
  }

  Future _openCamera(BuildContext context, provider) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    provider.image = File(pickedFile.path);
    this.setState(() {
      widget.onImageSelected();
    });
  }

  Future<void> _showChoiceDialog(BuildContext context, provider) =>
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Source',
            style: TextStyle(color: Colors.blue),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                    leading : Icon(Icons.photo_library_outlined),
                    title: Text("Gallery"),
                    onTap: () {
                      _openGallery(context, provider);
                    }
                ),
                ListTile(
                    leading : Icon(Icons.camera_alt_rounded),
                    title: Text("Camera"),
                    onTap: () {
                      _openCamera(context, provider);
                    }
                ),
              ],
            ),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<Data>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding*2, left: kDefaultPadding, right: kDefaultPadding),
                  child: Text("Information about $kAppName",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding*1.5, right: kDefaultPadding),
                  child: Text("This app makes use of an advanced AI model that takes a photo an analyzes it. Scan all the detected faces in the image and display their attributes which a percentage that represents the confidence of each attribute.",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding*2, left: kDefaultPadding, right: kDefaultPadding),
                  child: Text("Usage",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding*1.5, right: kDefaultPadding),
                  child: Text("1. Press the '+' button to select an image.\n2. Select the source of the image\n3. Confirm the upload\n4. Wait for the results!",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                provider.image != null ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding*3, left: kDefaultPadding, right: kDefaultPadding,
                          bottom: kDefaultPadding/2),
                      child: Text("Last Scan:",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
                      child: Center(
                        child: Column(
                          children : <Widget> [
                            Padding(
                              padding: EdgeInsets.all(kDefaultPadding/4),
                              child: Consumer<Data> (
                                builder: (context, provider, _) => Image.file(
                                  provider.image,
                                  width: size.width*0.8,
                                  height: size.height*0.5,
                                ),
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: kDefaultPadding/2, left: kDefaultPadding, right: kDefaultPadding, bottom: kDefaultPadding*3,),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                color: Colors.blue,
                                child: Text('Re-Scan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  this.setState(() {
                                    widget.onImageSelected();
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ) : Padding(padding: EdgeInsets.only(top: kDefaultPadding*6),),
                Padding(
                  padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
                  child: Center(
                    child: Column(
                      children : <Widget> [
                        Padding(
                          padding: EdgeInsets.only(top: kDefaultPadding/2, left: kDefaultPadding, right: kDefaultPadding),
                          child: Text(
                            "from",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: kDefaultPadding/2, left: kDefaultPadding, right: kDefaultPadding, bottom: kDefaultPadding*3),
                          child: Text(
                            "${kAppName}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showChoiceDialog(context, provider);
        },
        tooltip: 'Pick Image',
        child: Icon(
          Icons.add_rounded,
          color: kBackgroundColor,
          size: 35.0,
          semanticLabel: 'Open selection menu',
        ),
      ),
    );
  }
}

