import 'package:g_mcp/index.dart';
import '../../util/flutter_theme.dart';
import '../../util/flutter_util.dart';
import '../../util/flutter_widgets.dart';
import '../components/drawer_custom.dart';
import '../components/loaderspinner.dart';

import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../constants/widget_constants.dart';

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
        body:
            tablet || tabletland ? homewidg(context) : homePhonewidg(context));
  }

//Phone
  Widget homePhonewidg(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/images/Iphone.png'),
              fit: phone ? BoxFit.fitWidth : BoxFit.fitHeight)),
      child: SingleChildScrollView(
          child: Center(
        child: _load
            ? LoaderSpinner()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (phone ? 1.45 : 1),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/images/${"menuiphone.png"}'),
                        fit: phone ? BoxFit.fitWidth : BoxFit.fitHeight)),
                child: Stack(
                  children: [
                    //PROJECTS
                    CreatBtn(
                        1,
                        phone ? 0.2 : 0.03, //top
                        phone ? 0.1 : 0.42, //left
                        "",
                        phone ? 140 : 70, //width
                        phone ? 250 : 120, //height
                        100,
                        MenusWidgets.PROJECTS(context).widgets),

                    //BIO
                    CreatBtn(
                        3,
                        phone ? 0.55 : 0.335, //top
                        phone ? 0.12 : 0.44, //left
                        "",
                        phoneland ? 50 : 140, //width
                        phoneland ? 60 : 170, //height
                        100,
                        MenusWidgets.BIO(context).widgets),
                    //COLLECTORS
                    CreatBtn(
                        0,
                        phone ? 1.2 : 0.8, //top
                        phone ? 0.379 : 0.475, //left
                        "Collectors",
                        phone ? 120 : 50, //width
                        phone ? 120 : 50, //height
                        100,
                        MenusWidgets.COLLECTORS(context).widgets),
                    //WEB
                    CreatBtn(
                        4,
                        phone ? 0.71 : 0.5, //top
                        phone ? 0.47 : 0.5, //left
                        "WEB",
                        phone ? 160 : 45, //width
                        phone ? 370 : 105, //left
                        100,
                        BiopageWidget()),
                    //CATALOGUE (WORKS)
                    createDownBtn(
                        2,
                        phone ? 0.36 : 0.18, //top
                        phone ? 0.53 : 0.505, //left
                        "",
                        phone ? 150 : 200, //width
                        phoneland ? 70 : 200, //height
                        100,
                        MenusWidgets.CATALOGUE(context).widgets),
                    //AR
                    createDownBtn(
                        5,
                        phone ? 1.01 : 0.64, //top
                        phoneland ? 0.435 : 0.12, //left
                        "",
                        phone ? 130 : 50, //width
                        phone ? 150 : 60, //height
                        100,
                        MenusWidgets.AR(context).widgets)
                  ],
                ),
              ),
      )));

//Tablet
  Widget homewidg(BuildContext context) => Container(
          child: Center(
        child: _load
            ? LoaderSpinner()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/images/${"menutablet2.jpg"}'),
                        fit: BoxFit.fitHeight)),
                child: Stack(
                  children: [
                    //PROJECTS
                    CreatBtn(
                      1,
                      tablet ? 0.164 : 0.16, //top
                      tablet ? 0.1 : 0.27, //left
                      "",
                      tablet ? 210 : 190, //width
                      tablet ? 400 : 40, //height
                      100,
                      MenusWidgets.PROJECTS(context).widgets,
                    ),
                    //BIO
                    CreatBtn(
                        3,
                        tablet ? 0.38 : 0.35, //top
                        tablet ? 0.36 : 0.435, //left
                        "",
                        tablet ? 200 : 140, //width
                        tablet ? 230 : 220, //heigth
                        100,
                        MenusWidgets.BIO(context).widgets),
                    //COLLECTORS
                    CreatBtn(
                        0,
                        tablet ? 0.69 : 0.69, //top
                        tablet ? 0.37 : 0.44, //left
                        "Collectors",
                        tablet ? 210 : 50, //width
                        tablet ? 250 : 180, //height
                        100,
                        MenusWidgets.COLLECTORS(context).widgets),
                    //WEB
                    CreatBtn(
                        4,
                        tablet ? 0.55 : 0.47 //top
                        ,
                        tablet ? 0.68 : 0.58, //left
                        "WEB",
                        200, //width
                        400, //height
                        100,
                        BiopageWidget()),
                    //WORKS
                    createDownBtn(
                        2,
                        tablet ? 0.21 : 0.2, //top
                        tablet ? 0.625 : 0.57, //left
                        "",
                        200, //height
                        tablet ? 300 : 240, //width
                        100,
                        MenusWidgets.CATALOGUE(context).widgets),
                    //AR
                    createDownBtn(
                        5,
                        tablet ? 0.6 : 0.56, //top
                        tablet ? 0.1 : 0.25, //left
                        "",
                        220, //heigth
                        tablet ? 250 : 230, //width
                        100,
                        MenusWidgets.AR(context).widgets)
                  ],
                ),
              ),
      ));
  Widget CreatBtn(int i, double top, double left, String txt, double w,
          double h, double botpad, Widget widg) =>
      Positioned(
        top: MediaQuery.of(context).size.height * top,
        left: (MediaQuery.of(context).size.width * left),
        child: Column(children: [
          Text(
            "",
            style: FlutterTheme.of(context).title1,
          ),
          FFButtonWidget(
              onPressed: () async {
                FFAppState.setIDx(i);
                txt == "WEB"
                    ? await launchURL('https://gabrielrico.com/')
                    : txt == "INSTAGRAM"
                        ? await launchURL(
                            'https://www.instagram.com/gabrielricoestudio/')
                        : await Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => widg)));
              },
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
  Widget createDownBtn(int i, double top, double left, String txt, double w,
          double h, double botpad, Widget widg) =>
      Positioned(
        top: MediaQuery.of(context).size.height * top,
        left: (MediaQuery.of(context).size.width * left),
        child: Column(children: [
          FFButtonWidget(
              onPressed: () async {
                FFAppState.setIDx(i);
                await Navigator.push(
                    context, MaterialPageRoute(builder: ((context) => widg)));
              },
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
