import 'package:flutter/material.dart';
import 'package:imagga_app/clients/models/face_model.dart';
import 'package:imagga_app/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ListViewFaces extends StatelessWidget {
  Face face;
  int position;
  double faceConfidence;

  ListViewFaces(Face f, int pos) {
    this.face = f;
    this.position = (pos+1);
    this.faceConfidence = ((double.parse(this.face.ethnicityConfidence)+
        double.parse(this.face.genderConfidence)+
        double.parse(this.face.ageConfidence))/3.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container (
      child: Column(
        children: <Widget> [
          Padding(
              padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
              child: Text("Attributes detected for face ${this.position}",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              )
          ), Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: <Widget> [
                  Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: Text("Age",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      )
                  ), Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: Text("${this.face.age}",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18),
                      )
                  ), Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: double.parse(this.face.ageConfidence)/100.0,
                        center: new Text("${double.parse(this.face.ageConfidence).truncate()}%"),
                        progressColor: Colors.green,
                      )
                  ),
                ],
              ),
              Column(
                children: <Widget> [
                  Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: Text("Gender",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      )
                  ), Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: Text("${this.face.gender}",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18),
                      )
                  ), Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: double.parse(this.face.genderConfidence)/100.0,
                        center: new Text("${double.parse(this.face.genderConfidence).truncate()}%"),
                        progressColor: Colors.green,
                      )
                  ),
                ],
              ),
              Column(
                children: <Widget> [
                  Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: Text("Ethnicity",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      )
                  ), Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: Text("${this.face.ethnicity}",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18),
                      )
                  ), Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: double.parse(this.face.ethnicityConfidence)/100.0,
                        center: new Text("${double.parse(this.face.ethnicityConfidence).truncate()}%"),
                        progressColor: Colors.green,
                      )
                  ),
                ],
              ),
            ],
          ), Padding(
            padding: EdgeInsets.only(top: kDefaultPadding*2, left: kDefaultPadding, right: kDefaultPadding),
            child: Text(
                "The face ${this.position} was found in the coordinates of te image:\nHeight: ${this.face.height}, Width ${this.face.width}, Xlabel {${this.face.xmin} px, ${this.face.xmax} px} and  Ylabel {${this.face.ymin} px, ${this.face.ymax} px}."
            ),
          ), Padding(
              padding: EdgeInsets.only(top: kDefaultPadding*2, left: kDefaultPadding, right: kDefaultPadding, bottom: kDefaultPadding*2),
              child: Text.rich(
                  TextSpan(
                      text: "The AI model determined that the results for the analyzed face were determinated with an overall confidence of ",
                      children: <TextSpan> [
                        TextSpan(text: "${this.faceConfidence.truncate()}%", style: TextStyle(fontWeight: FontWeight.bold))
                      ]
                  )
              )
          ),
        ],
      ),
    );
  }
}
