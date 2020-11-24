import 'package:flutter/cupertino.dart';

class NavigationModel {
  String title;
  IconData icon;
  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: 'Dashboard', icon: CupertinoIcons.rectangle_3_offgrid),
  NavigationModel(title: 'Results', icon: CupertinoIcons.table_badge_more),
  NavigationModel(
      title: 'Students', icon: CupertinoIcons.person_2_square_stack_fill),
  NavigationModel(title: 'Teachers', icon: CupertinoIcons.suit_club),
  NavigationModel(title: 'Subjects', icon: CupertinoIcons.book_circle),
  NavigationModel(title: 'Setting', icon: CupertinoIcons.settings),
];
