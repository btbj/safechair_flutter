import 'package:flutter/material.dart';

class UnitSwitch extends StatelessWidget {
  final bool isF;
  final Function onTap;
  UnitSwitch({this.isF, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Theme.of(context).primaryColor;
    final Color inactiveColor = Colors.grey[700];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: isF ? inactiveColor : activeColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  '℃',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: !isF ? inactiveColor : activeColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  '℉',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
