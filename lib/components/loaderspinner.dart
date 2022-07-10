import 'package:flutter/material.dart';

class LoaderSpinner extends StatelessWidget {
  // This widget is the root of your application.
  final Color color;
  final double h;
  final double w;
  LoaderSpinner({Key key, this.color, this.h, this.w}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: CircularProgressIndicator(
                color: color == null ? Color.fromRGBO(0, 0, 0, 1) : color,
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(color),
              ),
              height: h == null ? 50.0 : h,
              width: w == null ? 50.0 : w,
            )
          ]),
    ));
  }
}
