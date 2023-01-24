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

    double ln = phone || phoneland ? 250 : 375;
    String _PATH = phone || phoneland
        ? "assets/images/GR_ipad.png"
        : "assets/images/GR_ipad.png";
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
                    FFAppState.getBio().info1 +
                        FFAppState.getBio().list1[0].toString() +
                        FFAppState.getBio().list1[1].toString() +
                        FFAppState.getBio().list1[2].toString() +
                        FFAppState.getBio().list1[3].toString() +
                        FFAppState.getBio().list1[4].toString() +
                        FFAppState.getBio().info2 +
                        FFAppState.getBio().list2[0].toString() +
                        FFAppState.getBio().list2[1].toString() +
                        FFAppState.getBio().list2[2].toString() +
                        FFAppState.getBio().list2[3].toString(),
                    textAlign: TextAlign.justify,
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
