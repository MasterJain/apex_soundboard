import 'package:apex_soundboard/abouthelpers/ui_helper.dart';

import 'package:flutter/material.dart';

class SexyTile extends StatelessWidget {
  const SexyTile({
    required this.child,
    required this.color,
    required this.splashColor,
    required this.onTap,
  });
  final Widget child;
  final Color color;
  final Color splashColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Material(
        color: color,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(15.0),
        shadowColor: Colors.black,
        child: InkWell(
          child: child,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(15.0),
          onTap: onTap == null ? doNothing : () => onTap(),
        ),
      ),
    );
  }
}
