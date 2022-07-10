import 'package:g_mcp/Models/project.dart';

import 'package:flutter/material.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/components/projectwidget%20.dart';
import 'package:g_mcp/index.dart';

import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';

class ProyectsListWidget extends StatefulWidget {
  const ProyectsListWidget({Key key}) : super(key: key);

  @override
  _ProyectsListWidget createState() => _ProyectsListWidget();
}

class _ProyectsListWidget extends State<ProyectsListWidget> {
  List<Project> _projects;
  void initState() {
    super.initState();
    if (FFAppState.getCatalogues() == null) {
      FFAppState.readJsonProjects().then((value) {
        FFAppState.setProjects(value);
        _projects = value;
      });
    } else {
      _projects = FFAppState.getProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool phone = responsiveVisibility(context: context, phone: true);

    bool tablet = responsiveVisibility(context: context, tablet: true);
    bool phoneland =
        responsiveVisibility(context: context, phoneLanspace: true);

    return FutureBuilder(
      future: FFAppState.readJsonProjects(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("Error: ${data.error}"));
        } else if (data.hasData) {
          _projects = data.data as List<Project>;
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _projects.length,
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.fromSTEB(
                  phone
                      ? 20
                      : phoneland
                          ? 40
                          : tablet
                              ? 0
                              : 40,
                  MediaQuery.of(context).size.height * 0.05,
                  0,
                  20),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                            reverseDuration: Duration(milliseconds: 0),
                            child: GenericPageWidget(
                                title: _projects[index].idStructure,
                                widg: ProjectWidget(
                                  project: _projects[index],
                                ))),
                      );
                    },
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 10, 0, !phone ? 40 : 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${_projects[index].titulo}.",
                                style: FlutterTheme.of(context).title2),
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Text(
                                  "${_projects[index].lugar}",
                                  style: FlutterTheme.of(context).bodyText1,
                                ))
                          ],
                        )));
              });
        } else {
          return LoaderSpinner();
        }
      },
    );
  }
}
