import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsm/theme.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final Function onTap;
  final AnimationController animationController;
  CollapsingListTile(
      {@required this.title,
      @required this.icon,
      this.isSelected = false,
      this.onTap,
      @required this.animationController});
  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> _widthAnimation;
  Animation<double> _sizedboxAnimation;
  @override
  void initState() {
    super.initState();
    _widthAnimation =
        Tween<double>(begin: maxSidebarWidth, end: minSidebarWidth)
            .animate(widget.animationController);
    _sizedboxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
            width: widget.isSelected ? 4 : 0,
            color: widget.isSelected
                ? listTileSelectedTextStyle.color
                : Colors.transparent,
          )),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.02)
              : Colors.transparent,
        ),
        width: _widthAnimation.value,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 25,
              color: widget.isSelected
                  ? listTileSelectedTextStyle.color
                  : listTileDefaultTextStyle.color,
            ),
            SizedBox(
              width: _sizedboxAnimation.value,
            ),
            (_widthAnimation.value >= 220)
                ? Text(
                    widget.title,
                    style: widget.isSelected
                        ? listTileSelectedTextStyle
                        : listTileDefaultTextStyle,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
