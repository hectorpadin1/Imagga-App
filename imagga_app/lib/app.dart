import 'package:flutter/material.dart';

import 'package:imagga_app/constants.dart';
import 'package:imagga_app/provider.dart';
import 'package:provider/provider.dart';
import 'package:imagga_app/widgets/master_detail_builder.dart';

class ImaggaApp extends StatelessWidget {
  final String title;

  ImaggaApp({
    this.title = kAppName,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      builder: (_) => Data(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MasterDetailBuilder(),
      ),
    );
  }
}