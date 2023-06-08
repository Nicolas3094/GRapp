import 'package:flutter/material.dart';

import '../../logic/util/flutter_util.dart';
import '../models/menus.dart';

class DrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerWidget({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    bool phoneland =
        responsiveVisibility(context: context, phoneLanspace: true);
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
            child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    20, !phoneland ? 40 : 0, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () =>
                              widget.scaffoldKey.currentState.closeDrawer(),
                          child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 50.0,
                              ))),
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
                ))));
  }
}
