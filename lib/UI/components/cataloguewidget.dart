import 'package:flutter/material.dart';
import 'package:g_mcp/UI/components/projectwidget%20.dart';
import 'package:g_mcp/UI/components/swipeimage_widget.dart';

import '../../data/Models/infostructure.dart';
import '../util/flutter_util.dart';
import 'data_category_widget.dart';

class CatalogueWidget extends StatefulWidget {
  final bool showDescription;
  final InfoStructure structList;
  final int initIndex;

  CatalogueWidget({this.showDescription, this.structList, this.initIndex = 0});
  @override
  _CatalogueWidget createState() => _CatalogueWidget();
}

class _CatalogueWidget extends State<CatalogueWidget> {
  int lenimgs;
  String _name;
  @override
  void initState() {
    _name = widget.showDescription ? "project" : "catalogue";
    super.initState();
  }

  bool phone;
  bool tablet;
  bool tabletland;

  double pad;
  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    pad = tablet || tabletland ? 40.0 : 30.0;
    return verticalView(context, widget.initIndex);
  }

  Widget verticalView(BuildContext context, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          width: MediaQuery.of(context).size.width,
          child: _name == "catalogue"
              ? DataCategoryWidget(
                  actualCatg: widget.structList,
                  index: index,
                )
              : ProjectWidget(
                  project: widget.structList,
                  numText: 0,
                  index: index,
                ),
        ),
        Flexible(
            child: Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SwipeImagesWidget(
                  project: this._name == "project" ? widget.structList : null,
                  catalogue:
                      this._name == "catalogue" ? widget.structList : null,
                ))),
      ],
    );
  }
}
