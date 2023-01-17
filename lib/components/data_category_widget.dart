import 'package:g_mcp/Models/catalogue.dart';
import 'package:flutter/material.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';

class DataCategoryWidget extends StatefulWidget {
  final Catalogue actualCatg;
  const DataCategoryWidget({
    Key key,
    this.actualCatg,
  }) : super(key: key);

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
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              0, 0, 0, tablet || tabletland ? 40 : 30),
          child: Text(
            "${widget.actualCatg.title}",
            textAlign: TextAlign.justify,
            style: FlutterTheme.of(context).bodyText2,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
          child: Text(
            "${widget.actualCatg.descriptionENG}",
            style: FlutterTheme.of(context).bodyText1,
          ),
        )
      ],
    );
  }
}
