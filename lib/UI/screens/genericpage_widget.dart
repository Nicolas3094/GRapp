import '../../logic/util/flutter_theme.dart';
import '../../logic/util/flutter_util.dart';
import '../components/appbar.dart';

import '../components/backbtn.dart';
import '../components/drawer_custom.dart';
import 'package:flutter/material.dart';

class GenericPageWidget extends StatefulWidget {
  final Widget widg;
  const GenericPageWidget({Key key, this.widg}) : super(key: key);

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
        appBar: BarApp(scaffoldKey: scaffoldKey),
        backgroundColor: FlutterTheme.of(context).primaryBtnText,
        drawer: DrawerWidget(scaffoldKey: scaffoldKey),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsetsDirectional.fromSTEB(
                    tablet //start
                        ? 20
                        : tabletland
                            ? 20
                            : 14,
                    tablet || tabletland //top
                        ? 20
                        : phone
                            ? 10
                            : 20,
                    tablet //end
                        ? 20
                        : tabletland
                            ? 40
                            : 14,
                    tablet //bottom
                        ? 0
                        : tabletland
                            ? 20
                            : phone || phoneland
                                ? 0
                                : 20),
                child: widget.widg),
          ),
          BackBtn()
        ]));
  }
}
