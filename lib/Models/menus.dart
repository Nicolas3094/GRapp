import 'package:flutter/material.dart';

import '../biopage/biopage_widget.dart';
import '../components/proyects_list_widget.dart';
import '../genericpage/genericpage_widget.dart';
import '../home_page/home_page_widget.dart';
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
      TextButton(
        style: ButtonStyle(),
        onPressed: fn,
        child: Text(
          name,
          style: FlutterTheme.of(context).title1,
        ),
      );
  static Widget navBtn(String name, Widget fn, BuildContext context) =>
      TextButton(
        onPressed: (() => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => fn)))),
        child: Text(name, style: FlutterTheme.of(context).title1),
      );

  static Widget navBtnLink(String name, String url, BuildContext context) =>
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
          style: FlutterTheme.of(context).title1,
        ),
      );
  static Widget Home(BuildContext context) =>
      navBtn("00 Home", HomePageWidget(), context);
  static Widget Projects(BuildContext context) => navBtn(
      "01 Projects",
      GenericPageWidget(
          title: "PROJECTS & EXHIBITIONS",
          widg: ProyectsListWidget(
            isProject: true,
          )),
      context);
  static Widget Catalogue(BuildContext context) => navBtn(
      "02 Catalogue",
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
  static Widget Collectors(BuildContext context) =>
      navBtn("05 Collectors", HomePageWidget(), context);
  static Widget Press(BuildContext context) =>
      navBtn("06 Press", HomePageWidget(), context);
  static Widget Lang(BuildContext context) =>
      actBtn("ESP/ENG", () => null, context);
  static Widget Instagram(BuildContext context) => navBtnLink("Instagram",
      "https://www.instagram.com/galerieperrotin/?hl=es-la", context);
  static Widget Contact(BuildContext context) =>
      actBtn("Contact", () => null, context);
}
