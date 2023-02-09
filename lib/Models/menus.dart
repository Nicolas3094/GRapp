import 'package:flutter/material.dart';
import 'package:g_mcp/UI/constants/widget_constants.dart';
import '../UI/components/proyects_list_widget.dart';
import '../UI/constants/constanst.dart';
import '../UI/pages/biopage_widget.dart';
import '../UI/pages/collectorsPage.dart';
import '../UI/pages/genericpage_widget.dart';
import '../UI/pages/home_page_widget.dart';
import '../UI/pages/unityscreens/arpage.dart';
import '../main.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import '../util/internationalization.dart';

class MenuW {
  static final MenuW _singleton = MenuW._internal();

  factory MenuW() {
    return _singleton;
  }
  MenuW._internal();
  static Widget actBtn(String name, Function fn, BuildContext context) =>
      InkWell(
        onTap: fn,
        child: Container(
            alignment: Alignment.center,
            child: Text(
              name,
              textAlign: TextAlign.left,
              style: FlutterTheme.of(context).navBar,
            )),
      );
  static Widget navBtn(String name, Widget fn, BuildContext context, int i) =>
      InkWell(
        onTap: () {
          MyApp.of(context).setIndexMenu(i);

          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => fn)));
        },
        child: Text(name,
            textAlign: TextAlign.left,
            style: FlutterTheme.of(context).navBar.override(
                fontStyle: FFAppState.getIDx() != i
                    ? FontStyle.normal
                    : FontStyle.italic)),
      );

  static Widget navBtnLink(
          String name, String url, BuildContext context, int i) =>
      InkWell(
        onTap: () async {
          FFAppState.setIDx(i);

          await launchURL(url);
        },
        child: Container(
            alignment: Alignment.center,
            child: Text(
              name,
              textAlign: TextAlign.left,
              style: FlutterTheme.of(context).navBar,
            )),
      );
  static Widget Home(BuildContext context) => navBtn(
      MenusWidgets.HOME(context).name,
      MenusWidgets.HOME(context).widgets,
      context,
      0);
  static Widget Projects(BuildContext context) => navBtn(
      MenusWidgets.PROJECTS(context).name,
      MenusWidgets.PROJECTS(context).widgets,
      context,
      1);

  static Widget Catalogue(BuildContext context) => navBtn(
      MenusWidgets.CATALOGUE(context).name,
      MenusWidgets.CATALOGUE(context).widgets,
      context,
      2);
  static Widget Bio(BuildContext context) => navBtn(
      MenusWidgets.BIO(context).name,
      MenusWidgets.BIO(context).widgets,
      context,
      3);
  static Widget Web(BuildContext context) =>
      navBtnLink("04 Web", Constants.WEB, context, 4);
  static Widget AR(BuildContext context) => navBtn(
      MenusWidgets.AR(context).name,
      MenusWidgets.AR(context).widgets,
      context,
      5);
  static Widget Collectors(BuildContext context) => navBtn(
      MenusWidgets.COLLECTORS(context).name,
      MenusWidgets.COLLECTORS(context).widgets,
      context,
      6);
  static Widget Press(BuildContext context) => navBtn(
      MenusWidgets.PRESS(context).name,
      MenusWidgets.PRESS(context).widgets,
      context,
      7);
  static Widget Lang(BuildContext context) => InkWell(
      onTap: () {
        MyApp.of(context).setLocale(Locale.fromSubtags(
            languageCode: FLocalizations.of(context).locale.languageCode == "es"
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
                      FLocalizations.of(context).locale.languageCode == "es"
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
                      FLocalizations.of(context).locale.languageCode == "es"
                          ? FontStyle.normal
                          : FontStyle.italic),
            ),
          ]));

  static Widget Instagram(BuildContext context) =>
      navBtnLink("Instagram", Constants.INSTAGRAM, context, 8);
  static Widget Contact(BuildContext context) => actBtn(
      FLocalizations.of(context).getText("a7yefkbw"),
      () => launEmail(Constants.EMAIL, "GRS", ""),
      context);
}
