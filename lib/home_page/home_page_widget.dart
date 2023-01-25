import 'package:g_mcp/components/appbar.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/index.dart';
import 'package:g_mcp/services/project_service.dart';

import '../Models/menus.dart';
import '../components/drawer_custom.dart';
import '../components/proyects_list_widget.dart';
import '../unityscreens/arpage.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import 'package:flutter/material.dart';
import '../components/appbar.dart';

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
  bool _load = false;
  double _shdw = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);

    phoneland = responsiveVisibility(context: context, phoneLanspace: true);

    tablet = responsiveVisibility(context: context, tablet: true);

    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    return Scaffold(
        key: _scaffoldKey,
        appBar: BarApp(scaffoldKey: _scaffoldKey),
        drawer: DrawerWidget(scaffoldKey: _scaffoldKey),
        body: tablet || tabletland
            ? homewidg(context)
            : SingleChildScrollView(child: homewidg(context)));
  }

  Widget homewidg(BuildContext context) => Container(
      color: Colors.white,
      child: Center(
        child: _load
            ? LoaderSpinner()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height *
                    (tablet || tabletland
                        ? 1
                        : phone
                            ? 1.4
                            : 1),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(
                            'assets/images/${tablet || tabletland ? "menutablet2.jpg" : "menuiphone.jpg"}'),
                        fit: tablet || tabletland
                            ? BoxFit.fitHeight
                            : phone
                                ? BoxFit.fitWidth
                                : BoxFit.fitHeight)),
                child: Stack(
                  children: [
                    CreatBtn(
                        tablet
                            ? 0.164
                            : tabletland
                                ? 0.16
                                : phone
                                    ? 0.17
                                    : 0.03,
                        tablet
                            ? 0.1
                            : phoneland
                                ? 0.42
                                : phone
                                    ? 0.1
                                    : 0.27,
                        "",
                        tablet
                            ? 210
                            : tabletland
                                ? 190
                                : phone
                                    ? 140
                                    : 70,
                        tablet
                            ? 400
                            : tabletland
                                ? 340
                                : phone
                                    ? 250
                                    : 120,
                        100,
                        GenericPageWidget(
                            title: "PROJECTS & EXHIBITIONS",
                            widg: ProyectsListWidget(
                              isProject: true,
                            ))),
                    CreatBtn(
                        tablet
                            ? 0.38
                            : phone
                                ? 0.5
                                : tabletland
                                    ? 0.35
                                    : 0.335,
                        tablet
                            ? 0.36
                            : phone
                                ? 0.16
                                : tabletland
                                    ? 0.435
                                    : 0.44,
                        "",
                        phoneland
                            ? 50
                            : tablet
                                ? 200
                                : 140,
                        tablet
                            ? 230
                            : phoneland
                                ? 60
                                : tabletland
                                    ? 220
                                    : 170,
                        100,
                        GenericPageWidget(
                          title: "BIO",
                          widg: BiopageWidget(),
                        )),
                    CreatBtn(
                        tablet
                            ? 0.69
                            : tabletland
                                ? 0.69
                                : phone
                                    ? 1.15
                                    : 0.8,
                        tablet
                            ? 0.37
                            : tabletland
                                ? 0.44
                                : phone
                                    ? 0.379
                                    : 0.475,
                        "Collectors",
                        tablet
                            ? 210
                            : phone
                                ? 120
                                : phoneland
                                    ? 50
                                    : 150,
                        tablet
                            ? 250
                            : tabletland
                                ? 180
                                : phone
                                    ? 120
                                    : 50,
                        100,
                        HomePageWidget()),
                    CreatBtn(
                        tablet
                            ? 0.55
                            : tabletland
                                ? 0.47
                                : phone
                                    ? 0.64
                                    : 0.5,
                        tablet
                            ? 0.68
                            : tabletland
                                ? 0.58
                                : phone
                                    ? 0.45
                                    : 0.5,
                        "WEB",
                        tablet || tabletland
                            ? 200
                            : phone
                                ? 160
                                : 45,
                        tablet || tabletland
                            ? 400
                            : phone
                                ? 370
                                : 105,
                        100,
                        BiopageWidget()),
                    createDownBtn(
                        tablet
                            ? 0.21
                            : tabletland
                                ? 0.2
                                : phone
                                    ? 0.3
                                    : 0.18,
                        tablet
                            ? 0.625
                            : tabletland
                                ? 0.57
                                : phone
                                    ? 0.53
                                    : 0.505,
                        "",
                        tablet
                            ? 280
                            : phone
                                ? 150
                                : phoneland
                                    ? 50
                                    : 200,
                        tablet
                            ? 300
                            : phoneland
                                ? 70
                                : phone
                                    ? 200
                                    : 240,
                        100,
                        GenericPageWidget(
                            title: "CATALOGUE",
                            widg: ProyectsListWidget(
                              isProject: false,
                            ))),
                    createDownBtn(
                        tablet
                            ? 0.6
                            : tabletland
                                ? 0.56
                                : phone
                                    ? 0.95
                                    : 0.64,
                        tablet
                            ? 0.1
                            : phoneland
                                ? 0.435
                                : phone
                                    ? 0.12
                                    : 0.25,
                        "",
                        tablet
                            ? 220
                            : phoneland
                                ? 50
                                : phone
                                    ? 130
                                    : 220,
                        tablet
                            ? 250
                            : phoneland
                                ? 60
                                : phone
                                    ? 150
                                    : 230,
                        100,
                        GenericPageWidget(
                          title: "AR EXPERIENCES",
                          widg: ARPageWidget(),
                        ))
                  ],
                ),
              ),
      ));
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

  Widget actBtn(String name, Function fn, BuildContext context) => TextButton(
        style: ButtonStyle(),
        onPressed: fn,
        child: Text(
          name,
          style: FlutterTheme.of(context).title2,
        ),
      );
  Widget navBtn(String name, Widget fn, BuildContext context) => TextButton(
        onPressed: (() => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => fn)))),
        child: Text(name, style: FlutterTheme.of(context).title2),
      );

  Widget navBtnLink(String name, String url, BuildContext context) =>
      TextButton(
        onPressed: (() => launchURL(url).then((value) => null)),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0)),
          textStyle: MaterialStateProperty.all(
            const TextStyle(),
          ),
        ),
        child: Text(
          name,
          style: FlutterTheme.of(context).title2,
        ),
      );
}
