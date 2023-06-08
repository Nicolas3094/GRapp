import 'package:flutter/material.dart';

import '../../data/Models/project.dart';
import '../../logic/util/flutter_theme.dart';
import '../../logic/util/flutter_util.dart';
import '../../logic/util/internationalization.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;
  final int numText;
  final int index;
  const ProjectWidget({Key key, this.project, this.numText, this.index})
      : super(key: key);

  @override
  _ProjectWidget createState() => _ProjectWidget();
}

class _ProjectWidget extends State<ProjectWidget> {
  final String name = "PROJECTS & EXHIBITIONS";

  @override
  Widget build(BuildContext context) {
    return widget.numText == 0
        ? principalInfo(context, widget.project, false)
        : widget.numText == 1
            ? principalInfo(context, widget.project, true)
            : secondaryInfo(context, widget.project);
  }

  Widget principalInfo(BuildContext context, Project project, bool bold) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 60, 0),
          child: Text(
            "${project.year}",
            style: FlutterTheme.of(context).bodyText1.override(
                fontStyle: FontStyle.normal,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ),
        Flexible(
            child: Container(
                width: 552,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.index < 9 ? '0' : ''}${widget.index + 1}. ${project.title}",
                      overflow: TextOverflow.clip,
                      style: FlutterTheme.of(context).bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "${project.year_place.replaceAll("\\n", "\n")}",
                      overflow: TextOverflow.clip,
                      style: FlutterTheme.of(context).bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          "${FLocalizations.of(context).locale.languageCode == "es" ? project.dataESP.replaceAll("\\n", "\n") : project.dataENG.replaceAll("\\n", "\n")}",
                          overflow: TextOverflow.clip,
                          style: FlutterTheme.of(context).bodyText1,
                          textAlign: TextAlign.left,
                        )),
                  ],
                ))),
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
            Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: boldTitle(project.title)),
            boldTitle(project.title),
            bodyInf(FLocalizations.of(context).locale.languageCode == "es"
                ? project.descriptionESP
                : project.descriptionENG),
          ],
        ));
  }
}
