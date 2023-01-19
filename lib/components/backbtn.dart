import 'package:flutter/material.dart';

import '../util/flutter_theme.dart';
import '../util/internationalization.dart';

class BackBtn extends StatelessWidget {
  final double size;
  final Color cl;
  BackBtn({this.size = 32, this.cl = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        iconSize: size,
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 20),
        constraints: BoxConstraints(),
        onPressed: () async => await Navigator.pop(context, true),
        icon: Image.asset("assets/images/Frame.png"),
        color: cl,
      ),
      Container(
        padding: EdgeInsetsDirectional.fromSTEB(19.64, 20, 0, 20),
        child: Text(
            FFLocalizations.of(context).locale.languageCode == "es"
                ? "Atrás"
                : "Back",
            style: FlutterTheme.of(context).title1),
      )
    ]);
  }
}
