import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/index.dart';

import '../components/cataloguewidget.dart';
import '../components/proyects_list_widget.dart';
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
                              fit: BoxFit.contain)),
                      child: Stack(
                        children: [
                          CreatBtn(
                              tablet
                                  ? 0.054
                                  : tabletland
                                      ? 0.044
                                      : phone
                                          ? 0.19
                                          : 0,
                              tablet
                                  ? 0.23
                                  : phoneland
                                      ? 0.4
                                      : phone
                                          ? 0.225
                                          : 0.34,
                              "",
                              tablet
                                  ? 190
                                  : tabletland
                                      ? 160
                                      : phone
                                          ? 80
                                          : 70,
                              tablet
                                  ? 150
                                  : tabletland
                                      ? 120
                                      : phone
                                          ? 80
                                          : 50,
                              100,
                              GenericPageWidget(
                                  title: "PROJECTS",
                                  widg: ProyectsListWidget())),
                          CreatBtn(
                              tablet
                                  ? 0.54
                                  : phone
                                      ? 0.51
                                      : tabletland
                                          ? 0.55
                                          : 0.49,
                              tablet
                                  ? 0.455
                                  : phone
                                      ? 0.435
                                      : tabletland
                                          ? 0.475
                                          : 0.468,
                              "",
                              phoneland
                                  ? 70
                                  : tablet
                                      ? 120
                                      : 70,
                              tablet
                                  ? 180
                                  : phoneland
                                      ? 60
                                      : tabletland
                                          ? 120
                                          : 70,
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
                                          ? 0.68
                                          : 0.75,
                              tablet
                                  ? 0.267
                                  : tabletland
                                      ? 0.36
                                      : phone
                                          ? 0.255
                                          : 0.405,
                              "",
                              tablet
                                  ? 100
                                  : phone
                                      ? 50
                                      : 60,
                              tablet
                                  ? 120
                                  : tabletland
                                      ? 100
                                      : phone
                                          ? 50
                                          : 50,
                              100,
                              SimpleScreen()),
                          CreatBtn(
                              tablet
                                  ? 0.785
                                  : tabletland
                                      ? 0.77
                                      : phone
                                          ? 0.65
                                          : 0.7,
                              tablet
                                  ? 0.675
                                  : tabletland
                                      ? 0.594
                                      : phone
                                          ? 0.66
                                          : 0.55,
                              "WEB",
                              tablet || tabletland ? 60 : 35,
                              tablet || tabletland ? 60 : 35,
                              100,
                              BiopageWidget()),
                          CreatBtn(
                              tablet
                                  ? 0.785
                                  : tabletland
                                      ? 0.77
                                      : phone
                                          ? 0.398
                                          : 0.3,
                              tablet
                                  ? 0.675
                                  : tabletland
                                      ? 0.594
                                      : phone
                                          ? 0.6
                                          : 0.53,
                              "INSTAGRAM",
                              tablet || tabletland ? 60 : 40,
                              tablet || tabletland ? 60 : 40,
                              100,
                              BiopageWidget()),
                          createDownBtn(
                              tablet
                                  ? 0.11
                                  : tabletland
                                      ? 0.11
                                      : phone
                                          ? 0.25
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
                                      ? 110
                                      : 100,
                              tablet
                                  ? 220
                                  : phoneland
                                      ? 70
                                      : phone
                                          ? 110
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
                                          ? 0.37
                                          : 0.27,
                              tablet
                                  ? 0.325
                                  : phoneland
                                      ? 0.425
                                      : phone
                                          ? 0.28
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
                              SimpleScreen())
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
                      ? await launchURL(
                          'https://www.instagram.com/gabrielricoestudio/')
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
