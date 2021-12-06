import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imagga_app/clients/models/face_model.dart';
import 'package:imagga_app/provider.dart';
import 'package:imagga_app/widgets/list_view.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:imagga_app/clients/imagga_client.dart';
import 'package:imagga_app/constants.dart';
import 'package:provider/provider.dart';

class ViewResponse extends StatefulWidget {
  final bool reload;

  const ViewResponse({Key key, this.reload}) : super(key: key);

  @override
  _ViewResponseState createState() => _ViewResponseState();
}

class _ViewResponseState extends State<ViewResponse> {
  Future<List<Face>> _faces;

  @override
  void initState() {
    super.initState();
    this.didChangeDependencies();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _faces = _loadData();
    });
  }

  Future<List<Face>> _loadData() async {
    final provider = Provider.of<Data>(context, listen: false);
    ImaggaClient client = provider.client;
    return await client.loadImageDataURL(provider.image);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: _faces,
        builder: (BuildContext context, AsyncSnapshot<List<Face>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
            List<Face> data = snapshot.data;
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: data.length != 0 ? ( Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding,
                          left: kDefaultPadding,
                          right: kDefaultPadding),
                      child: Text("Analyzed Photo",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      )
                  ), Padding(
                    padding: EdgeInsets.only(
                        top: kDefaultPadding/2,
                        left: kDefaultPadding,
                        right: kDefaultPadding),
                        child: Consumer<Data> (
                          builder: (context, provider, _) => Image.file(
                              provider.image,
                              height: size.height * 0.6,
                              width: size.width * 0.95),
                        ),
                  ), Padding(
                      padding: EdgeInsets.only(
                          top: kDefaultPadding,
                          left: kDefaultPadding,
                          right: kDefaultPadding),
                      child: Text("Overall Confidence",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                  ), Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding,
                          left: kDefaultPadding,
                          right: kDefaultPadding),
                      child: CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 7.5,
                        percent: double.parse(data[0].overallConfidence)/100.0,
                        center: new Text("${double.parse(data[0].overallConfidence).truncate()}%"),
                        progressColor: kSecondaryColor,
                      )
                  ), Padding(
                    padding: EdgeInsets.only(top: kDefaultPadding,
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding*2),
                    child: Text.rich(
                      TextSpan(
                          text: "The AI model that analyzed this image has determined an overall confidence level of the results of ",
                          children: <TextSpan>[
                            TextSpan(text: "${double.parse(data[0].overallConfidence).truncate()}%.",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ]
                      ),
                    ),
                  ), ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int i) =>
                      new ListViewFaces(data[i],i)
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding*3),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text('Re-Scan',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        _reload();
                      },
                    ),
                  ),
                ],
              )) :
              Center(
                child: Column(children : <Widget> [
                  Padding(
                    padding: EdgeInsets.only(top: kDefaultPadding,
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding,),
                    child: Text("Whoops!",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: kDefaultPadding/2,
                        left: kDefaultPadding,
                        right: kDefaultPadding),
                    child: Consumer<Data> (
                      builder: (context, provider, _) => Image.file(
                          provider.image,
                          height: size.height * 0.6,
                          width: size.width * 0.95),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: kDefaultPadding*2,
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding/4),
                    child: Text("Looks like we couldn\'t identify any face",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding*2),
                    child: Text("in the given image. Please try again.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: kDefaultPadding*2),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        color: Colors.blue,
                        child: Text('Try again',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          _reload();
                        },
                      ),
                  ),
                ],
                ),
              ),
            );
          }
          else if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding,
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding*2,),
                      child: Text("Whoops!",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: kDefaultPadding/2),
                      child: Text('Something unexpected happened, we couldn\'t'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Text('connect your phone to the internet.'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: kDefaultPadding*2),
                      child: Text('Please check your internet connection.'),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      color: Colors.blue,
                      child: Text('Try again',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        _reload();
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }
    );
  }

  void _reload() {
    final provider = Provider.of<Data>(context, listen: false);
    ImaggaClient client = provider.client;
    setState(() {
      _faces = client.loadImageDataURL(provider.image);
    });
  }
}
