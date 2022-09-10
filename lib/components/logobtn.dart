import 'package:flutter/material.dart';
import 'package:g_mcp/components/proyects_list_widget.dart';
import '../biopage/biopage_widget.dart';
import '../genericpage/genericpage_widget.dart';
import '../unityscreens/arpage.dart';
import '../util/flutter_util.dart';
import '../home_page/home_page_widget.dart';
import 'cataloguewidget.dart';

class LogoBtn extends StatelessWidget {
  List<PopupMenuEntry<int>> _menus;
  final List<Widget> _widgs = [
    HomePageWidget(),
    GenericPageWidget(title: "BIO", widg: BiopageWidget()),
    GenericPageWidget(
        title: "CATALOGUE",
        widg: CatalogueWidget(
          showDescription: false,
          structList: FFAppState.getCatalogues(),
        )),
    GenericPageWidget(
        title: "PROJECTS & EXHIBITIONS", widg: ProyectsListWidget()),
    GenericPageWidget(
      title: "AR EXPERIENCES",
      widg: ARPageWidget(),
    ),
    GenericPageWidget(
      title: "AR EXPERIENCES",
      widg: ARPageWidget(),
    )
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
            : 40;
    final double h = w;
    TextStyle headerstl = TextStyle(
        fontSize: tablet || tabletland ? 22 : 16,
        fontFamily: "Headingpro",
        fontWeight: FontWeight.bold,
        color: Colors.black);
    _menus = [
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
        width: w * 0.9,
        height: h * 0.9,
        fit: BoxFit.cover,
      ),
      itemBuilder: (context) => _menus);
}
