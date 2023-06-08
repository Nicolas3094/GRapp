import 'package:flutter/cupertino.dart';

import '../../logic/util/internationalization.dart';
import '../components/proyects_list_widget.dart';
import '../screens/biopage_widget.dart';
import '../screens/none_page.dart';
import '../screens/genericpage_widget.dart';
import '../screens/home_page_widget.dart';
import '../screens/press_page_widget.dart';
import '../screens/unityscreens/arpage.dart';

class MenuWidget {
  String name;
  Widget widgets;

  MenuWidget(this.name, this.widgets);
  factory MenuWidget.make(String name, Widget widgets) =>
      MenuWidget(name, widgets);
}

class MenusWidgets {
  static MenuWidget HOME(BuildContext context) => MenuWidget.make(
      "00 " + FLocalizations.of(context).getText("4vb80p5u"), HomePageWidget());
  static MenuWidget PROJECTS(BuildContext context) => MenuWidget.make(
      "01 " + FLocalizations.of(context).getText("Projects"),
      GenericPageWidget(
          widg: ProyectsListWidget(
        isProject: true,
      )));
  static MenuWidget CATALOGUE(BuildContext context) => MenuWidget.make(
      "02 " + FLocalizations.of(context).getText("w1j9xq7t"),
      GenericPageWidget(
          widg: ProyectsListWidget(
        isProject: false,
      )));
  static MenuWidget BIO(BuildContext context) =>
      MenuWidget.make("03 Bio", GenericPageWidget(widg: BiopageWidget()));
  static MenuWidget AR(BuildContext context) => MenuWidget.make(
      "05 AR",
      GenericPageWidget(
        widg: ARPageWidget(),
      ));
  static MenuWidget COLLECTORS(BuildContext context) => MenuWidget.make(
      "06 " + FLocalizations.of(context).getText("ozkeslzw"),
      GenericPageWidget(
        widg: NonePage(name: FLocalizations.of(context).getText("z9jlpsmq")),
      ));
  static MenuWidget PRESS(BuildContext context) => MenuWidget.make(
      "07 " + FLocalizations.of(context).getText("7qqisvlq"),
      GenericPageWidget(
        widg: PressPageWidget(),
      ));
}
