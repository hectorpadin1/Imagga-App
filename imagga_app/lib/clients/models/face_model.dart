class Face {
  final String overallConfidence;
  final String age;
  final String ageConfidence;
  final String gender;
  final String genderConfidence;
  final String ethnicity;
  final String ethnicityConfidence;
  final int height;
  final int width;
  final int xmax;
  final int xmin;
  final int ymax;
  final int ymin;

  Face({this.overallConfidence,this.age,this.ageConfidence,this.gender,
    this.genderConfidence,this.ethnicity,this.ethnicityConfidence,this.height,
    this.width,this.xmax,this.xmin,this.ymax,this.ymin});

  factory Face.fromJsonList(jsonList) {
    return Face(
      overallConfidence: jsonList['confidence'].toString(),
      age: jsonList['attributes'][0]['label'].toString(),
      ageConfidence: jsonList['attributes'][0]['confidence'].toString(),
      gender: jsonList['attributes'][1]['label'].toString(),
      genderConfidence: jsonList['attributes'][1]['confidence'].toString(),
      ethnicity: jsonList['attributes'][2]['label'].toString(),
      ethnicityConfidence: jsonList['attributes'][2]['confidence'].toString(),
      height: jsonList['coordinates']['height'],
      width: jsonList['coordinates']['width'],
      xmax: jsonList['coordinates']['xmax'],
      xmin: jsonList['coordinates']['xmin'],
      ymax: jsonList['coordinates']['ymax'],
      ymin: jsonList['coordinates']['ymin'],
    );
  }
}