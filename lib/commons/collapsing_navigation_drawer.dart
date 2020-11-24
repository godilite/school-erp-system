import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsm/commons/collapsing_list_tile.dart';
import 'package:fsm/models/navigation_model.dart';
import 'package:fsm/theme.dart';
import 'package:fsm/views/dashboard_view.dart';
import 'package:fsm/views/results_view.dart';
import 'package:fsm/views/students_view.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  int currentIndex = 0;
  AnimationController _animationController;
  Animation<double> _widthAnimation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _widthAnimation =
        Tween<double>(begin: maxSidebarWidth, end: minSidebarWidth)
            .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => buildWidget(context, widget),
    );
  }

  Widget buildWidget(context, widget) {
    return Row(
      children: [
        Container(
          width: _widthAnimation.value,
          decoration: BoxDecoration(
            color: drawbackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: <Widget>[
              CollapsingListTile(
                title: 'Godwin Asuquo',
                icon: CupertinoIcons.person,
                animationController: _animationController,
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 60,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 20,
                      color: Colors.transparent,
                    );
                  },
                  itemBuilder: (context, counter) {
                    return CollapsingListTile(
                        onTap: () {
                          setState(() {
                            currentIndex = counter;
                          });
                        },
                        isSelected: currentIndex == counter ? true : false,
                        title: navigationItems[counter].title,
                        icon: navigationItems[counter].icon,
                        animationController: _animationController);
                  },
                  itemCount: navigationItems.length,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: _animationController,
                  color: listTileDefaultTextStyle.color,
                  size: 30.0,
                ),
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: BuildPages(currentIndex),
          ),
        )
      ],
    );
  }
}

class BuildPages extends StatelessWidget {
  final int index;

  BuildPages(this.index);
  final pages = [DashboardView(), ResultView(), StudentView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, body: pages[index]);
  }
}
