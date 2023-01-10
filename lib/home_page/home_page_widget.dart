import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/index.dart';

import '../components/cataloguewidget.dart';
import '../components/proyects_list_widget.dart';
import '../unityscreens/arpage.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import 'package:flutter/material.dart';

import '../util/flutter_widgets.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with SingleTickerProviderStateMixin {
  bool tablet;
  bool tabletland;
  bool phone;
  bool phoneland;
  bool _load = true;
  double _shdw = 0;

  @override
  void initState() {
    super.initState();

    if (FFAppState.getCatalogues() == null) {
      FFAppState.readJsonCatalogues()
          .then((value) => {FFAppState.setCatalogues(value)})
          .whenComplete(() => setState(() => _load = false));
    } else {
      setState(() {
        _load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);

    phoneland = responsiveVisibility(context: context, phoneLanspace: true);

    tablet = responsiveVisibility(context: context, tablet: true);

    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    return Scaffold(
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/MenuFondo.jpg'),
                    fit: BoxFit.cover)),
            child: Center(
              child: _load
                  ? LoaderSpinner()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/mural_reduccion.gif'),
                              fit: tablet || tabletland
                                  ? BoxFit.contain
                                  : BoxFit.fitHeight)),
                      child: Stack(
                        children: [
                          CreatBtn(
                              tablet
                                  ? 0.054
                                  : tabletland
                                      ? 0.044
                                      : phone
                                          ? 0.05
                                          : 0,
                              tablet
                                  ? 0.23
                                  : phoneland
                                      ? 0.4
                                      : phone
                                          ? 0.06
                                          : 0.34,
                              "",
                              tablet
                                  ? 190
                                  : tabletland
                                      ? 160
                                      : phone
                                          ? 140
                                          : 70,
                              tablet
                                  ? 150
                                  : tabletland
                                      ? 120
                                      : phone
                                          ? 100
                                          : 50,
                              100,
                              GenericPageWidget(
                                  title: "PROJECTS & EXHIBITIONS",
                                  widg: ProyectsListWidget())),
                          CreatBtn(
                              tablet
                                  ? 0.54
                                  : phone
                                      ? 0.55
                                      : tabletland
                                          ? 0.55
                                          : 0.49,
                              tablet
                                  ? 0.455
                                  : phone
                                      ? 0.425
                                      : tabletland
                                          ? 0.475
                                          : 0.468,
                              "",
                              phoneland
                                  ? 70
                                  : tablet
                                      ? 120
                                      : 100,
                              tablet
                                  ? 180
                                  : phoneland
                                      ? 60
                                      : tabletland
                                          ? 120
                                          : 100,
                              100,
                              GenericPageWidget(
                                title: "BIO",
                                widg: BiopageWidget(),
                              )),
                          CreatBtn(
                              tablet
                                  ? 0.83
                                  : tabletland
                                      ? 0.815
                                      : phone
                                          ? 0.83
                                          : 0.75,
                              tablet
                                  ? 0.267
                                  : tabletland
                                      ? 0.36
                                      : phone
                                          ? 0.105
                                          : 0.405,
                              "",
                              tablet
                                  ? 100
                                  : phone
                                      ? 80
                                      : 60,
                              tablet
                                  ? 120
                                  : tabletland
                                      ? 100
                                      : phone
                                          ? 70
                                          : 50,
                              100,
                              SimpleScreen(sceneID: 3)),
                          CreatBtn(
                              tablet
                                  ? 0.785
                                  : tabletland
                                      ? 0.77
                                      : phone
                                          ? 0.78
                                          : 0.7,
                              tablet
                                  ? 0.675
                                  : tabletland
                                      ? 0.594
                                      : phone
                                          ? 0.79
                                          : 0.55,
                              "WEB",
                              tablet || tabletland ? 60 : 45,
                              tablet || tabletland ? 60 : 45,
                              100,
                              BiopageWidget()),
                          CreatBtn(
                              tablet
                                  ? 0.785
                                  : tabletland
                                      ? 0.77
                                      : phone
                                          ? 0.35
                                          : 0.3,
                              tablet
                                  ? 0.675
                                  : tabletland
                                      ? 0.594
                                      : phone
                                          ? 0.65
                                          : 0.53,
                              "INSTAGRAM",
                              tablet || tabletland ? 60 : 80,
                              tablet || tabletland ? 60 : 80,
                              100,
                              BiopageWidget()),
                          createDownBtn(
                              tablet
                                  ? 0.11
                                  : tabletland
                                      ? 0.11
                                      : phone
                                          ? 0.1
                                          : 0.11,
                              tablet
                                  ? 0.525
                                  : tabletland
                                      ? 0.5
                                      : phone
                                          ? 0.53
                                          : 0.505,
                              "",
                              tablet
                                  ? 250
                                  : phone
                                      ? 180
                                      : 100,
                              tablet
                                  ? 220
                                  : phoneland
                                      ? 70
                                      : phone
                                          ? 160
                                          : 80,
                              100,
                              GenericPageWidget(
                                  title: "CATALOGUE",
                                  widg: CatalogueWidget(
                                      showDescription: false,
                                      structList: FFAppState.getCatalogues()))),
                          createDownBtn(
                              tablet
                                  ? 0.305
                                  : tabletland
                                      ? 0.3
                                      : phone
                                          ? 0.31
                                          : 0.27,
                              tablet
                                  ? 0.325
                                  : phoneland
                                      ? 0.425
                                      : phone
                                          ? 0.22
                                          : 0.4,
                              "",
                              tablet
                                  ? 80
                                  : phoneland
                                      ? 50
                                      : 60,
                              tablet
                                  ? 100
                                  : phoneland
                                      ? 50
                                      : 60,
                              100,
                              GenericPageWidget(
                                title: "AR EXPERIENCES",
                                widg: ARPageWidget(),
                              ))
                        ],
                      ),
                    ),
            )),
      ),
    );
  }

  Widget CreatBtn(double top, double left, String txt, double w, double h,
          double botpad, Widget widg) =>
      Positioned(
        top: MediaQuery.of(context).size.height * top,
        left: (MediaQuery.of(context).size.width * left),
        child: Column(children: [
          Text(
            "",
            style: FlutterTheme.of(context).title1,
          ),
          FFButtonWidget(
              onPressed: () async => txt == "WEB"
                  ? await launchURL('https://gabrielrico.com/')
                  : txt == "INSTAGRAM"
                      ? await launchURL('https://gabrielrico.com/')
                      : await Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => widg))),
              options: FFButtonOptions(
                  color: Color.fromARGB(0, 255, 255, 255),
                  height: h,
                  width: w,
                  elevation: _shdw,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, botpad),
                  textStyle: FlutterTheme.of(context).title1),
              text: " ",
              showLoadingIndicator: true)
        ]),
      );
  Widget createDownBtn(double top, double left, String txt, double w, double h,
          double botpad, Widget widg) =>
      Positioned(
        top: MediaQuery.of(context).size.height * top,
        left: (MediaQuery.of(context).size.width * left),
        child: Column(children: [
          FFButtonWidget(
              onPressed: () async => await Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => widg))),
              options: FFButtonOptions(
                  color: Color.fromARGB(0, 255, 255, 255),
                  height: h,
                  width: w,
                  elevation: _shdw,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, botpad),
                  textStyle: FlutterTheme.of(context).title1),
              text: " ",
              showLoadingIndicator: true),
          Text(
            txt,
            style: FlutterTheme.of(context).title1,
          ),
        ]),
      );
}
