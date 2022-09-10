import 'package:g_mcp/util/flutter_util.dart';
import '../components/logobtn.dart';
import '../components/backbtn.dart';
import '../util/flutter_theme.dart';
import 'package:flutter/material.dart';

class GenericPageWidget extends StatefulWidget {
  final String title;
  final Widget widg;
  const GenericPageWidget({Key key, this.title, this.widg}) : super(key: key);

  @override
  _GenericPageWidget createState() => _GenericPageWidget();
}

class _GenericPageWidget extends State<GenericPageWidget>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool tablet;
  bool tabletland;
  bool phone;
  bool phoneland;
  AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 500));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);

    phoneland = responsiveVisibility(context: context, phoneLanspace: true);

    tablet = responsiveVisibility(context: context, tablet: true);

    tabletland = responsiveVisibility(context: context, tabletLandscape: true);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterTheme.of(context).primaryBtnText,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsetsDirectional.fromSTEB(
            tablet //start
                ? 80
                : tabletland
                    ? 40
                    : 30,
            tablet || tabletland //top
                ? 60
                : phone
                    ? 40
                    : 20,
            tablet //end
                ? 100
                : tabletland
                    ? 40
                    : 40,
            tablet //bottom
                ? 80
                : tabletland
                    ? 60
                    : phone || phoneland
                        ? 20
                        : 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0,
                      0,
                      0,
                      tablet || tabletland
                          ? 40
                          : phone
                              ? 35
                              : 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackBtn(
                        size: 38,
                      ),
                      Center(
                        child: LogoBtn(),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          tablet || tabletland ? 15 : 10,
                          0,
                          0,
                          tablet || tabletland ? 40 : 10),
                      child: Text(
                        "${widget.title}",
                        style: FlutterTheme.of(context).title1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(child: widget.widg))),
          ],
        ),
      ),
    );
  }
}
