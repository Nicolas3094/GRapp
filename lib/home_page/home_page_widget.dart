import 'package:g_mcp/components/appbar.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/index.dart';

import '../Models/menus.dart';
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
  bool _load = true;
  double _shdw = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      key: _scaffoldKey,
      appBar: BarApp(scaffoldKey: _scaffoldKey),
      drawer: Drawer(
          child: Padding(
              padding:
                  EdgeInsetsDirectional.fromSTEB(20, !phoneland ? 40 : 0, 0, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuW.Home(context),
                    MenuW.Projects(context),
                    MenuW.Catalogue(context),
                    MenuW.Bio(context),
                    MenuW.Web(context),
                    MenuW.AR(context),
                    MenuW.Collectors(context),
                    MenuW.Press(context),
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    ),
                    MenuW.Lang(context),
                    MenuW.Instagram(context),
                    MenuW.Contact(context)
                  ],
                ),
              ))),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: _load
                  ? LoaderSpinner()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/${tablet || tabletland ? "menutablet2.jpg" : "menuiphone.jpg"}'),
                              fit: tablet || tabletland
                                  ? BoxFit.fitHeight
                                  : BoxFit.fitHeight)),
                      child: Stack(
                        children: [
                          CreatBtn(
                              tablet
                                  ? 0.154
                                  : tabletland
                                      ? 0.14
                                      : phone
                                          ? 0.07
                                          : 0.03,
                              tablet
                                  ? 0.1
                                  : phoneland
                                      ? 0.42
                                      : phone
                                          ? 0.17
                                          : 0.27,
                              "",
                              tablet
                                  ? 210
                                  : tabletland
                                      ? 190
                                      : phone
                                          ? 130
                                          : 70,
                              tablet
                                  ? 380
                                  : tabletland
                                      ? 180
                                      : phone
                                          ? 180
                                          : 80,
                              100,
                              GenericPageWidget(
                                  title: "PROJECTS & EXHIBITIONS",
                                  widg: ProyectsListWidget(
                                    isProject: true,
                                  ))),
                          CreatBtn(
                              tablet
                                  ? 0.34
                                  : phone
                                      ? 0.3
                                      : tabletland
                                          ? 0.35
                                          : 0.25,
                              tablet
                                  ? 0.36
                                  : phone
                                      ? 0.225
                                      : tabletland
                                          ? 0.435
                                          : 0.44,
                              "",
                              phoneland
                                  ? 50
                                  : tablet
                                      ? 170
                                      : 120,
                              tablet
                                  ? 230
                                  : phoneland
                                      ? 60
                                      : tabletland
                                          ? 140
                                          : 130,
                              100,
                              GenericPageWidget(
                                title: "BIO",
                                widg: BiopageWidget(),
                              )),
                          CreatBtn(
                              tablet
                                  ? 0.69
                                  : tabletland
                                      ? 0.65
                                      : phone
                                          ? 0.75
                                          : 0.69,
                              tablet
                                  ? 0.37
                                  : tabletland
                                      ? 0.42
                                      : phone
                                          ? 0.399
                                          : 0.475,
                              "Collectors",
                              tablet
                                  ? 180
                                  : phone
                                      ? 90
                                      : 50,
                              tablet
                                  ? 180
                                  : tabletland
                                      ? 140
                                      : phone
                                          ? 80
                                          : 50,
                              100,
                              null),
                          CreatBtn(
                              tablet
                                  ? 0.5
                                  : tabletland
                                      ? 0.4
                                      : phone
                                          ? 0.57
                                          : 0.41,
                              tablet
                                  ? 0.64
                                  : tabletland
                                      ? 0.56
                                      : phone
                                          ? 0.55
                                          : 0.5,
                              "WEB",
                              tablet || tabletland ? 200 : 45,
                              tablet || tabletland ? 400 : 105,
                              100,
                              BiopageWidget()),
                          createDownBtn(
                              tablet
                                  ? 0.21
                                  : tabletland
                                      ? 0.21
                                      : phone
                                          ? 0.2
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
                                      ? 90
                                      : 50,
                              tablet
                                  ? 250
                                  : phoneland
                                      ? 70
                                      : phone
                                          ? 120
                                          : 180,
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
                                      ? 0.6
                                      : phone
                                          ? 0.61
                                          : 0.6,
                              tablet
                                  ? 0.1
                                  : phoneland
                                      ? 0.435
                                      : phone
                                          ? 0.25
                                          : 0.25,
                              "",
                              tablet
                                  ? 200
                                  : phoneland
                                      ? 60
                                      : 100,
                              tablet
                                  ? 200
                                  : phoneland
                                      ? 60
                                      : 120,
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
