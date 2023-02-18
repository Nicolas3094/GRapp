import 'package:flutter/material.dart';
import '../models/menus.dart';
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

  @override
  Widget build(BuildContext context) {
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
                  //HOME
                  menubtn(MenuW.Home(context)),
                  //PROJECTS
                  menubtn(MenuW.Projects(context)),
                  //WORTKS
                  menubtn(MenuW.Catalogue(context)),
                  //BIO
                  menubtn(MenuW.Bio(context)),
                  //WEB
                  menubtn(MenuW.Web(context)),
                  //AR
                  menubtn(MenuW.AR(context)),
                  //COLLECTORS
                  menubtn(MenuW.Collectors(context)),
                  //PRESS
                  menubtn(MenuW.Press(context)),
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
        if (tablet || tabletland) menubtn(MenuW.Lang(context)),
        if (tablet || tabletland) menubtn(MenuW.Instagram(context)),
        if (tablet || tabletland)
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: MenuW.Contact(context))
      ],
    );
  }

  Widget menubtn(Widget menu) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
      child: menu,
    );
  }
}
