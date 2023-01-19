import 'package:flutter/material.dart';

import 'package:g_mcp/Models/menus.dart';
import 'package:g_mcp/components/proyects_list_widget.dart';
import 'package:g_mcp/main.dart';

import '../biopage/biopage_widget.dart';
import '../genericpage/genericpage_widget.dart';
import '../home_page/home_page_widget.dart';
import '../unityscreens/arpage.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';

class BarApp extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Size get preferredSize => const Size.fromHeight(40);
  const BarApp({this.scaffoldKey});
  @override
  _BarApp createState() => _BarApp();
}

class _BarApp extends State<BarApp> {
  @override
  void initState() {
    super.initState();
  }

  double fontsz = 12;
  Widget actBtn(String name, Function fn, BuildContext context) => TextButton(
        style: ButtonStyle(),
        onPressed: fn,
        child: Text(
          name,
          style: FlutterTheme.of(context).title1,
        ),
      );
  Widget navBtn(String name, Widget fn, BuildContext context) => TextButton(
        onPressed: (() => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => fn)))),
        child: Text(name, style: FlutterTheme.of(context).title1),
      );

  Widget navBtnLink(String name, String url, BuildContext context) =>
      TextButton(
        onPressed: (() => launchURL(url).then((value) => null)),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0)),
          textStyle: MaterialStateProperty.all(
            const TextStyle(),
          ),
        ),
        child: Text(
          name,
          style: FlutterTheme.of(context).title1,
        ),
      );
  @override
  Widget build(BuildContext context) {
    bool phone = responsiveVisibility(context: context, phone: true);

    bool phoneland =
        responsiveVisibility(context: context, phoneLanspace: true);

    bool tablet = responsiveVisibility(context: context, tablet: true);

    bool tabletland =
        responsiveVisibility(context: context, tabletLandscape: true);
    context = context;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.black),
      title: tablet || tabletland
          ? Container(
              padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MenuW.Home(context),
                  navBtn(
                      "01 " + FFLocalizations.of(context).getText("Projects"),
                      GenericPageWidget(
                          title: "PROJECTS & EXHIBITIONS",
                          widg: ProyectsListWidget(
                            isProject: true,
                          )),
                      context),
                  navBtn(
                      "02 " + FFLocalizations.of(context).getText("w1j9xq7t"),
                      GenericPageWidget(
                          title: "CATALOGUE",
                          widg: ProyectsListWidget(
                            isProject: false,
                          )),
                      context),
                  navBtn(
                      "03 " + FFLocalizations.of(context).getText("rx0220np"),
                      GenericPageWidget(
                        title: "BIO",
                        widg: BiopageWidget(),
                      ),
                      context),
                  navBtnLink("04 Web", "https://gabrielrico.com/", context),
                  navBtn(
                      "05 AR",
                      GenericPageWidget(
                        title: "AR EXPERIENCES",
                        widg: ARPageWidget(),
                      ),
                      context),
                  navBtn(
                      "06 " + FFLocalizations.of(context).getText("ozkeslzw"),
                      HomePageWidget(),
                      context),
                  navBtn(
                      "07 " + FFLocalizations.of(context).getText("7qqisvlq"),
                      HomePageWidget(),
                      context),
                ],
              ))
          : Container(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () =>
                          widget.scaffoldKey.currentState.openDrawer(),
                      icon: Icon(Icons.menu))
                ],
              )),
      actions: [
        if (tablet || tabletland)
          actBtn(
              "ESP/ENG",
              () => MyApp.of(context).setLocale(Locale.fromSubtags(
                  languageCode:
                      FFLocalizations.of(context).locale.languageCode == "es"
                          ? "en"
                          : "es")),
              context),
        if (tablet || tabletland)
          navBtnLink("Instagram",
              "https://www.instagram.com/galerieperrotin/?hl=es-la", context),
        if (tablet || tabletland)
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
              child: actBtn(FFLocalizations.of(context).getText("a7yefkbw"),
                  () => null, context))
      ],
    );
  }
}
