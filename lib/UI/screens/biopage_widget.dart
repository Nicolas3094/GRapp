import 'package:flutter/material.dart';

import '../app_state.dart';
import '../util/flutter_theme.dart';
import '../util/internationalization.dart';

class BiopageWidget extends StatefulWidget {
  const BiopageWidget({Key key}) : super(key: key);

  @override
  _BiopageWidgetState createState() => _BiopageWidgetState();
}

class _BiopageWidgetState extends State<BiopageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              width: MediaQuery.of(context).size.width,
              child: Image.asset(FFAppState.getBio().img),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FLocalizations.of(context).locale.languageCode == "es"
                        ? FFAppState.getBio().descriptionESP
                        : FFAppState.getBio().descriptionENG,
                    textAlign: TextAlign.left,
                    style: FlutterTheme.of(context).bodyText3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
