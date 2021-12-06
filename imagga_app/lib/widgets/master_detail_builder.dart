import 'package:flutter/material.dart';

import 'package:imagga_app/provider.dart';
import 'package:imagga_app/widgets/horizontal/landscape_orientation.dart';
import 'package:imagga_app/widgets/vertical/vertical_orientation.dart';
import 'package:provider/provider.dart';

class MasterDetailBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Data>(context, listen: false);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          int breakPoint = provider.breakpoint;
          bool chooseMasterAndDetail = constraints.smallest.longestSide > breakPoint &&
              MediaQuery.of(context).orientation == Orientation.landscape;
          return chooseMasterAndDetail ? LandScapeOrientation() : VerticalScreen();
        }
    );
  }
}
