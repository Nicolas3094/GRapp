import 'package:g_mcp/components/logobtn.dart';
import 'package:g_mcp/components/backbtn.dart';

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
    bool tablet = responsiveVisibility(context: context, tablet: true);

    bool tabletland =
        responsiveVisibility(context: context, tabletLandscape: true);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterTheme.of(context).primaryBtnText,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [BackBtn()],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (tablet || tabletland)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/fotoGR.jpeg',
                                    width: phone || !tablet || !tabletland
                                        ? 150
                                        : 200,
                                    height: phone || !tablet || !tabletland
                                        ? 150
                                        : 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if (phone || phoneland)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/fotoGR.jpeg',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: LogoBtn(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: tablet || tabletland
                        ? EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10)
                        : EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              "${FFAppState.getBio().idStructure}",
                              style: FlutterTheme.of(context).title1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 5),
                            child: Text(
                              FFAppState.getBio().info1,
                              textAlign: TextAlign.justify,
                              style: FlutterTheme.of(context).bodyText1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20, tablet || tabletland ? 10 : 5, 20, 0),
                            child: Text(
                              FFAppState.getBio().info2,
                              textAlign: TextAlign.justify,
                              style: FlutterTheme.of(context).bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
