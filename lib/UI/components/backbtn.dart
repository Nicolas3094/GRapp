import 'package:flutter/material.dart';

import '../app_state.dart';

class BackBtn extends StatefulWidget {
  final double size;
  final Color cl;
  BackBtn({this.size = 32, this.cl = Colors.black});
  @override
  _BackBtn createState() => _BackBtn();
}

class _BackBtn extends State<BackBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        iconSize: widget.size,
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 20),
        constraints: BoxConstraints(),
        onPressed: () async {
          setState(() => FFAppState.popIdx());
          await Navigator.pop(context, true);
        },
        icon: Image.asset("assets/images/Frame.png"),
        color: widget.cl,
      )
    ]);
  }
}
