import 'package:g_mcp/Models/catalogue.dart';
import 'package:g_mcp/Models/project.dart';

import 'package:flutter/material.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/index.dart';

import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import 'cataloguewidget.dart';

class ProyectsListWidget extends StatefulWidget {
  final bool isProject;
  const ProyectsListWidget({Key key, this.isProject}) : super(key: key);

  @override
  _ProyectsListWidget createState() => _ProyectsListWidget();
}

class _ProyectsListWidget extends State<ProyectsListWidget> {
  List<Project> _projects;
  List<Catalogue> _catalogues;

  int len = 0;

  void initState() {
    super.initState();
    if (widget.isProject) {
      if (FFAppState.getProjects() == null) {
        FFAppState.readJsonProjects().then((value) {
          FFAppState.setProjects(value);
          _projects = value;
        });
      } else {
        _projects = FFAppState.getProjects();
      }
    } else {
      if (FFAppState.getCatalogues() == null) {
        FFAppState.readJsonCatalogues().then((value) {
          FFAppState.setCatalogues(value);
          _catalogues = value;
        });
      } else {
        _catalogues = FFAppState.getCatalogues();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool phone = responsiveVisibility(context: context, phone: true);

    bool tablet = responsiveVisibility(context: context, tablet: true);
    bool phoneland =
        responsiveVisibility(context: context, phoneLanspace: true);

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: widget.isProject
              ? FFAppState.readJsonProjects()
              : FFAppState.readJsonCatalogues(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("Error: ${data.error}"));
            } else if (data.hasData) {
              int len;
              if (widget.isProject) {
                _projects = data.data as List<Project>;
                len = _projects.length;
              } else {
                _catalogues = data.data as List<Catalogue>;
                len = _catalogues.length;
              }
              List<int> _items = List.generate(len, (i) => i);

              return Wrap(
                spacing: (phone || phoneland ? 3 : 11),
                runSpacing: (phone || phoneland ? 3 : 11),
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  for (var i in _items)
                    Container(
                      width: MediaQuery.of(context).size.width *
                          (phone
                              ? 0.42
                              : phoneland
                                  ? 0.3
                                  : 0.1666),
                      height: MediaQuery.of(context).size.height /
                          (phone
                              ? 5
                              : phoneland
                                  ? 1
                                  : 4),
                      child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                  child: GenericPageWidget(
                                      title: "PROJECTS & EXHIBITIONS",
                                      widg: CatalogueWidget(
                                        showDescription: widget.isProject,
                                        structList: widget.isProject
                                            ? _projects
                                            : _catalogues,
                                        initIndex: i,
                                      ))),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  child: Image.asset((widget.isProject
                                          ? _projects[i].dir
                                          : _catalogues[i].dir) +
                                      "1.jpg")),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 13, 0, 0),
                                  child: Row(
                                    children: [
                                      Text((i + 1).toString() + ".",
                                          style: FlutterTheme.of(context)
                                              .bodyText2),
                                      Text(
                                          "(${widget.isProject ? _projects[i].year : _catalogues[i].year})",
                                          style: FlutterTheme.of(context)
                                              .bodyText2),
                                    ],
                                  )),
                              Flexible(
                                  child: Text(
                                "${widget.isProject ? _projects[i].title : _catalogues[i].title}",
                                style: FlutterTheme.of(context).bodyText2,
                                overflow: TextOverflow.fade,
                              )),
                            ],
                          )),
                    ),
                ],
              );
            } else {
              return LoaderSpinner();
            }
          },
        ));
  }
}
