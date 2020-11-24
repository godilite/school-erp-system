import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsm/commons/collapsing_navigation_drawer.dart';
import 'package:fsm/theme.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: appBackgroundColor),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: CollapsingNavigationDrawer(),
          )
        ],
      ),
    );
  }
}
