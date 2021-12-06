import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:imagga_app/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'account_screen.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget> [
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(
              Icons.account_circle,
              size: 85.0,
              semanticLabel: 'DefaultProfile',
            ),
            accountEmail: Text(kUserEmail),
            accountName: Text(kUserName),
          ),
          ListTile(
            leading : Icon(Icons.account_circle),
            title: Text("Account"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Scaffold(
                        appBar: AppBar(
                          title: Text('Account'),
                        ),
                        body: MediaQuery.of(context).orientation == Orientation.landscape ?
                        Row(
                          children: <Widget> [
                            Flexible(
                              child: AccountScreen(),
                            ),
                            Flexible(
                                child: Material(
                                  elevation: 4.0,
                                  child: Center(
                                      child: Text(
                                        'Currently working a this...',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                  ),
                                )
                            ),
                          ],
                        ) : AccountScreen(),
                    );
                  },
                ),
              );
            },
          ),
          ListTile(
            leading : Icon(Icons.star_rate),
            title: Text("Rate App"),
            onTap: () {
              _showMyDialog(context);
            }
          ),
          AboutListTile(
            icon: Icon(Icons.info),
            applicationName: kAppName,
            aboutBoxChildren: <Widget>[
              Text('This application can recognise faces in a photo and tell us more about them.'),
            ],
          ),
        ],
      ),
    );
  }


  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rate our App'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding),
                  child: Center(
                    child: SmoothStarRating(
                      borderColor: Colors.black54,
                      color: Colors.orangeAccent,
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CLOSE',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),TextButton(
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showOk(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showOk(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thanks for your feedback!'),
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}