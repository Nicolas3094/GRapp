import 'package:flutter/material.dart';
import 'package:g_mcp/components/proyects_list_widget.dart';
import '../biopage/biopage_widget.dart';
import '../genericpage/genericpage_widget.dart';
import '../util/flutter_util.dart';
import '../home_page/home_page_widget.dart';
import '../unityscreens/simple_screen.dart';
import 'cataloguewidget.dart';

const TextStyle headerstl = TextStyle(
    fontSize: 22,
    fontFamily: "Headingpro",
    fontWeight: FontWeight.bold,
    color: Colors.black);

class LogoBtn extends StatelessWidget {
  final List<PopupMenuEntry<int>> _menus = [
    PopupMenuItem(
      textStyle: headerstl,
      child: Text("- HOME"),
      value: 0,
    ),
    PopupMenuItem(
      textStyle: headerstl,
      child: Text("- BIO"),
      value: 1,
    ),
    PopupMenuItem(
      textStyle: headerstl,
      child: Text("- CATALOGUE"),
      value: 2,
    ),
    PopupMenuItem(
      textStyle: headerstl,
      child: Text("- PROJECTS"),
      value: 3,
    ),
    PopupMenuItem(
      textStyle: headerstl,
      child: Text("- AR"),
      value: 4,
    ),
    PopupMenuItem(
      textStyle: headerstl,
      child: Text("- COLLECTORS"),
      value: 5,
    )
  ];
  final List<Widget> _widgs = [
    HomePageWidget(),
    BiopageWidget(),
    GenericPageWidget(title: "CATALOGUE", widg: CatalogueWidget()),
    GenericPageWidget(title: "PROJECTS", widg: ProyectsListWidget()),
    SimpleScreen(),
    SimpleScreen()
  ];
  @override
  Widget build(BuildContext context) {
    bool phoneland =
        responsiveVisibility(context: context, phoneLanspace: true);

    bool tablet = responsiveVisibility(context: context, tablet: true);

    bool tabletland =
        responsiveVisibility(context: context, tabletLandscape: true);
    final double w = phoneland
        ? 60
        : tablet || tabletland
            ? 70
            : 70;
    final double h = w;
    return popupMenu(context, h, w);
  }

  Widget popupMenu(BuildContext context, double w, double h) => PopupMenuButton(
      position: PopupMenuPosition.under,
      elevation: 0,
      offset: Offset(-30, 25),
      color: Color.fromARGB(205, 240, 240, 240),
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      onSelected: (value) async => await Navigator.push(
          context, MaterialPageRoute(builder: (context) => _widgs[value])),
      child: Image.asset(
        'assets/images/GR_LOGO.png',
        width: w,
        height: h,
        fit: BoxFit.cover,
      ),
      itemBuilder: (context) => _menus);
}
