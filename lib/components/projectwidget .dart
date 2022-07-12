import 'package:flutter/material.dart';
import 'package:g_mcp/Models/project.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;
  final int numText;
  const ProjectWidget({Key key, this.project, this.numText}) : super(key: key);

  @override
  _ProjectWidget createState() => _ProjectWidget();
}

class _ProjectWidget extends State<ProjectWidget> {
  final String name = "PROJECTS";
  final double fontitle = 32;
  final double fontitle2 = 26;
  bool _tablet;
  bool _tabletl;
  final double fontsz = 18;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _tablet = responsiveVisibility(context: context, tablet: true);
      _tabletl = responsiveVisibility(context: context, tabletLandscape: true);
    });

    return widget.numText == 0
        ? principalInfo(context, widget.project, false)
        : widget.numText == 1
            ? principalInfo(context, widget.project, true)
            : secondaryInfo(context, widget.project);
  }

  Widget principalInfo(BuildContext context, Project project, bool bold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
          child: Text(
            "${project.titulo}",
            style: FlutterTheme.of(context).bodyText1.override(
                fontStyle: bold ? FontStyle.normal : FontStyle.italic,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ),
        if (project.cuerpo != " ")
          Container(
            child: Text(
              "${project.cuerpo}",
              style: FlutterTheme.of(context).bodyText1,
              textAlign: TextAlign.justify,
            ),
          ),
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0, _tablet || _tabletl ? 10 : 10, 0, 0),
            child: InkWell(
              onTap: () => launchURL(project.web),
              child: Text(
                "${project.web}",
                style: FlutterTheme.of(context).bodyText1,
                textAlign: TextAlign.justify,
              ),
            )),
      ],
    );
  }

  Widget boldTitle(String dat) => Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Text("${dat}",
          textAlign: TextAlign.justify,
          style: FlutterTheme.of(context).bodyText1));

  Widget bodyInf(String dat) => Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 1.5, 0, 10),
      child: Text(
        "${dat}",
        textAlign: TextAlign.justify,
        style: FlutterTheme.of(context).bodyText1,
      ));

  Widget checkWeb(String dat) {
    final String _key = "https://";
    var splitted = dat.split(_key);
    final String legend = splitted[0];
    final String path = splitted[1];
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 1.5, 0, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (legend != " ")
              Text(
                "${legend}",
                textAlign: TextAlign.justify,
                style: FlutterTheme.of(context)
                    .bodyText1
                    .override(fontWeight: FontWeight.bold),
              ),
            Expanded(
                child: InkWell(
              onTap: () => launchURL(_key + path),
              child: Text(
                "${_key + path}",
                style: FlutterTheme.of(context).bodyText1,
                textAlign: TextAlign.justify,
              ),
            ))
          ],
        ));
  }

  Widget secondaryInfo(BuildContext context, Project project) {
    return SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.tit1 != " ") boldTitle(project.tit1),
            if (project.bod1 != " ") bodyInf(project.bod1),
            if (project.tit2 != " ") boldTitle(project.tit2),
            if (project.bod2 != " ") bodyInf(project.bod2),
            if (project.tit3 != " ") boldTitle(project.tit3),
            if (project.bod3 != " ") bodyInf(project.bod3),
            if (project.tit4 != " ") boldTitle(project.tit4),
            if (project.bod4 != " ") bodyInf(project.bod4),
            if (project.web1 != " ") checkWeb(project.web1),
            if (project.web2 != " ") checkWeb(project.web2),
            if (project.web3 != " ") checkWeb(project.web3),
            if (project.web4 != " ") checkWeb(project.web4),
          ],
        ));
  }

  Widget VerticalView(BuildContext context, Project project) => Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    child: principalInfo(context, project, false)),
              )
            ],
          ),
        ],
      );
}
