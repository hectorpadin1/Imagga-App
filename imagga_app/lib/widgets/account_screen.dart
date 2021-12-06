import 'package:flutter/material.dart';
import 'package:imagga_app/constants.dart';


class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget> [
            Padding(
                padding: const EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    top: kDefaultPadding
                ),
                child: Row(
                  children: <Widget> [
                    TextBoldStyle(
                      text: kUserName,
                    ),
                    Icon(
                      Icons.verified_user,
                      color: kSecondaryColor,
                    ),
                    Spacer(),
                    Icon(
                      Icons.account_circle,
                      size : 60,
                      color: kMainColor,
                    ),
                  ],
                )
            ),
            showText(
              text: "Surname: ${kUserSurname}",
              size: 15,
            ),
            showText(
              text: "Email: ${kUserEmail}",
              size: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kDefaultPadding*4
              ),
              child: Row(
                children: <Widget> [
                  TextBoldStyle(
                    text: "Active subscription",
                  ),
                ],
              ),
            ),
            showText(
              text: kSubscription,
              size: 15,
            ),
          ],
        ),
      );
  }
}

class TextBoldStyle extends StatelessWidget {
  const TextBoldStyle({
    Key key,
    this.text,
  }) : super(key : key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding/4),
            child: Text(
              text,
              style: TextStyle(
                  color: kTextColor2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class showText extends StatelessWidget {
  const showText({
    Key key,
    this.text,
    this.size,
  }) : super(key : key);

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefaultPadding*2,
          right: kDefaultPadding,
          top: kDefaultPadding
      ),
      child: Row(
        children: <Widget> [
          Text(
            text,
            style: TextStyle(
              color: kTextColor2,
              fontSize: size,
            ),
          ),
        ],
      ),
    );
  }
}