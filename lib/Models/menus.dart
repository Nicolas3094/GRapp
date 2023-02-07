import 'package:flutter/material.dart';
import 'package:g_mcp/CollectorsPage/collectorsPage.dart';

import '../biopage/biopage_widget.dart';
import '../components/proyects_list_widget.dart';
import '../genericpage/genericpage_widget.dart';
import '../home_page/home_page_widget.dart';
import '../main.dart';
import '../unityscreens/arpage.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';

class MenuW {
  static final MenuW _singleton = MenuW._internal();

  factory MenuW() {
    return _singleton;
  }
  MenuW._internal();
  static Widget actBtn(String name, Function fn, BuildContext context) =>
      InkWell(
        onTap: fn,
        child: Text(
          name,
          textAlign: TextAlign.left,
          style: FlutterTheme.of(context).navBar,
        ),
      );
  static Widget navBtn(String name, Widget fn, BuildContext context) => InkWell(
        onTap: (() => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => fn)))),
        child: Text(name,
            textAlign: TextAlign.left, style: FlutterTheme.of(context).navBar),
      );

  static Widget navBtnLink(String name, String url, BuildContext context) =>
      InkWell(
        onTap: (() => launchURL(url).then((value) => null)),
        child: Text(
          name,
          textAlign: TextAlign.left,
          style: FlutterTheme.of(context).navBar,
        ),
      );
  static Widget Home(BuildContext context) => navBtn(
      "00 " + FFLocalizations.of(context).getText("4vb80p5u"),
      HomePageWidget(),
      context);
  static Widget Projects(BuildContext context) => navBtn(
      "01 " + FFLocalizations.of(context).getText("Projects"),
      GenericPageWidget(
          title: "PROJECTS & EXHIBITIONS",
          widg: ProyectsListWidget(
            isProject: true,
          )),
      context);

  static Widget Catalogue(BuildContext context) => navBtn(
      "02 " + FFLocalizations.of(context).getText("w1j9xq7t"),
      GenericPageWidget(
          title: "CATALOGUE",
          widg: ProyectsListWidget(
            isProject: false,
          )),
      context);
  static Widget Bio(BuildContext context) => navBtn(
      "03 Bio",
      GenericPageWidget(
        title: "BIO",
        widg: BiopageWidget(),
      ),
      context);
  static Widget Web(BuildContext context) =>
      navBtnLink("04 Web", "https://gabrielrico.com/", context);
  static Widget AR(BuildContext context) => navBtn(
      "05 AR",
      GenericPageWidget(
        title: "AR EXPERIENCES",
        widg: ARPageWidget(),
      ),
      context);
  static Widget Collectors(BuildContext context) => navBtn(
      "06 " + FFLocalizations.of(context).getText("ozkeslzw"),
      GenericPageWidget(
        widg: CollectorsPage(),
      ),
      context);
  static Widget Press(BuildContext context) => navBtn(
      "07 " + FFLocalizations.of(context).getText("7qqisvlq"),
      HomePageWidget(),
      context);
  static Widget Lang(BuildContext context) => InkWell(
      onTap: () {
        MyApp.of(context).setLocale(Locale.fromSubtags(
            languageCode:
                FFLocalizations.of(context).locale.languageCode == "es"
                    ? "en"
                    : "es"));
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ESP",
              textAlign: TextAlign.left,
              style: FlutterTheme.of(context).navBar.override(
                  fontStyle:
                      FFLocalizations.of(context).locale.languageCode == "es"
                          ? FontStyle.italic
                          : FontStyle.normal),
            ),
            Text(
              "/",
              textAlign: TextAlign.left,
              style: FlutterTheme.of(context).navBar,
            ),
            Text(
              "ENG",
              textAlign: TextAlign.left,
              style: FlutterTheme.of(context).navBar.override(
                  fontStyle:
                      FFLocalizations.of(context).locale.languageCode == "es"
                          ? FontStyle.normal
                          : FontStyle.italic),
            ),
          ]));

  static Widget Instagram(BuildContext context) => navBtnLink(
      "Instagram", "https://www.instagram.com/gabrielricoestudio/", context);
  static Widget Contact(BuildContext context) => actBtn(
      FFLocalizations.of(context).getText("a7yefkbw"),
      () => launEmail("gabrielricoestudio@gmail.com", "GRS", ""),
      context);
}
