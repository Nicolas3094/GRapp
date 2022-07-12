import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import 'package:flutter/material.dart';

class BiopageWidget extends StatefulWidget {
  const BiopageWidget({Key key}) : super(key: key);

  @override
  _BiopageWidgetState createState() => _BiopageWidgetState();
}

class _BiopageWidgetState extends State<BiopageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool phone = responsiveVisibility(context: context, phone: true);
    bool phoneland =
        responsiveVisibility(context: context, phoneLanspace: true);

    double ln = phone || phoneland ? 200 : 300;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterTheme.of(context).primaryBtnText,
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                width: ln,
                height: ln,
                child: Image.asset("assets/images/fotoGR.jpeg"),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FFAppState.getBio().info1,
                      textAlign: TextAlign.justify,
                      style: FlutterTheme.of(context).bodyText3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
