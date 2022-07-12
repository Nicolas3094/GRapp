import 'package:g_mcp/Models/catalogue.dart';
import 'package:flutter/material.dart';
import '../util/flutter_theme.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
          child: Text(
            "${widget.actualCatg.title}",
            textAlign: TextAlign.justify,
            style: FlutterTheme.of(context).bodyText2,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
          child: Text(
            "${widget.actualCatg.data}",
            style: FlutterTheme.of(context).bodyText1,
          ),
        ),
        if (widget.actualCatg.info1 != " ")
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
            child: Text(
              "${widget.actualCatg.info1}",
              style: FlutterTheme.of(context).bodyText1,
            ),
          ),
        if (widget.actualCatg.info2 != " ")
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
            child: Text(
              "${widget.actualCatg.info2}",
              style: FlutterTheme.of(context).bodyText1,
            ),
          ),
        if (widget.actualCatg.info3 != " ")
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
            child: Text(
              "${widget.actualCatg.info3}",
              style: FlutterTheme.of(context).bodyText1,
            ),
          ),
      ],
    );
  }
}