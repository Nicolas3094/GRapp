import 'package:flutter/material.dart';

import '../../data/Models/catalogue.dart';
import '../../logic/util/flutter_theme.dart';
import '../../logic/util/flutter_util.dart';
import '../../logic/util/internationalization.dart';

class DataCategoryWidget extends StatefulWidget {
  final Catalogue actualCatg;
  final int index;
  const DataCategoryWidget({Key key, this.actualCatg, this.index})
      : super(key: key);

  @override
  _DataCategoryWidgetState createState() => _DataCategoryWidgetState();
}

class _DataCategoryWidgetState extends State<DataCategoryWidget> {
  bool phone;
  bool tablet;
  bool tabletland;
  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
        child: Text(
          "${widget.actualCatg.year}",
          style: FlutterTheme.of(context)
              .bodyText1
              .override(fontWeight: FontWeight.normal),
          textAlign: TextAlign.left,
        ),
      ),
      Flexible(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.index < 9 ? '0' : ''}${(widget.index + 1).toString()}. ${widget.actualCatg.title}",
            overflow: TextOverflow.clip,
            style: FlutterTheme.of(context).bodyText1,
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
            child: Text(
              "${FLocalizations.of(context).locale.languageCode == "es" ? widget.actualCatg.dataESP.replaceAll("\\n", "\n") : widget.actualCatg.dataENG.replaceAll("\\n", "\n")}",
              style: FlutterTheme.of(context).bodyText1,
            ),
          )
        ],
      ))
    ]);
  }
}
