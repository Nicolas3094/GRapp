import 'package:g_mcp/Models/project.dart';

import 'package:flutter/material.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/index.dart';

import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';

class ARPageWidget extends StatefulWidget {
  const ARPageWidget({Key key}) : super(key: key);

  @override
  _ARPageWidget createState() => _ARPageWidget();
}

class _ARPageWidget extends State<ARPageWidget> {
  List<Project> _arprojects;
  bool phone;
  bool tablet;
  bool tabletland;
  bool load = false;
  double pad;
  void initState() {
    super.initState();
    if (FFAppState.getARProjects() == null) {
      FFAppState.readJsonARProjects().then((value) {
        FFAppState.setARProjects(value);
        _arprojects = value;
      });
    } else {
      _arprojects = FFAppState.getARProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    pad = tablet || tabletland ? 40.0 : 30.0;

    return FutureBuilder(
      future: FFAppState.readJsonARProjects(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("Error: ${data.error}"));
        } else if (data.hasData) {
          _arprojects = data.data as List<Project>;
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _arprojects.length,
              shrinkWrap: true,
              padding:
                  EdgeInsetsDirectional.fromSTEB(tablet ? 5 : 0, 10, 0, 20),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async {
                      await showDataAlert(_arprojects[index]);
                      await Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                            child: SimpleScreen(
                              sceneID: index + 1,
                            )),
                      );
                    },
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 10, 0, phone ? 20 : 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              width: MediaQuery.of(context).size.width *
                                  (tablet ? 0.4 : 0.6),
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(_arprojects[index].dir +
                                          (index == 0 ? "1.jpeg" : "1.png")))),
                            ),
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Text("${_arprojects[index].title}",
                                    style: FlutterTheme.of(context)
                                        .title1
                                        .override(
                                            fontStyle: FontStyle.italic,
                                            fontSize: tablet ? 22 : 14))),
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                child: Text(
                                  "${_arprojects[index].lugar}",
                                  style: FlutterTheme.of(context)
                                      .bodyText1
                                      .override(fontWeight: FontWeight.bold),
                                )),
                            if (_arprojects[index].subtitulo != " ")
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Text("${_arprojects[index].subtitulo}",
                                      style: FlutterTheme.of(context)
                                          .bodyText1
                                          .override(
                                              fontStyle: FontStyle.italic)))
                          ],
                        )));
              });
        } else {
          return LoaderSpinner();
        }
      },
    );
  }

  Future<void> showDataAlert(Project project) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(230, 255, 255, 255),
          contentPadding:
              EdgeInsets.only(top: pad, bottom: pad, left: pad, right: pad),
          content: Container(
            height: tablet || tabletland
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width *
                (tablet || tabletland ? 0.55 : 0.6),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0,
                        tablet || tabletland ? 40 : 20,
                        0,
                        tablet || tabletland ? 40 : 20),
                    child: boldTitle(project.title),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 0, 0, tablet || tabletland ? 40 : 20),
                    child: boldSubTitle(project.cuerpo),
                  ),
                  if (project.tit1 != " ") bodyInf(project.tit1),
                  if (project.tit2 != " ") bodyInf(project.tit2),
                  if (project.tit3 != " ") bodyInf(project.tit3),
                  if (project.tit4 != " ") bodyInf(project.tit4),
                  if (project.bod4 != " ")
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, tablet || tabletland ? 40 : 20, 0, 0),
                      child: bodyBld(project.bod4),
                    )
                ],
              ),
            ),
          ),
        );
      });
  Widget boldTitle(String dat) => Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Text("${dat}",
          textAlign: TextAlign.justify,
          style: FlutterTheme.of(context).title1.override(
              fontStyle: FontStyle.italic, fontSize: tablet ? 22 : 14)));
  Widget boldSubTitle(String dat) => Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Text("${dat}",
          textAlign: TextAlign.justify,
          style: FlutterTheme.of(context).bodyText1.override(
              fontWeight: FontWeight.bold, fontSize: tablet ? 18 : 14)));
  Widget bodyInf(String dat) => Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 1.5, 0, 10),
      child: Text(
        "${dat}",
        textAlign: TextAlign.justify,
        style: FlutterTheme.of(context).bodyText1,
      ));
  Widget bodyBld(String dat) => Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 1.5, 0, 10),
      child: Text(
        "${dat}",
        textAlign: TextAlign.justify,
        style: FlutterTheme.of(context)
            .bodyText1
            .override(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
      ));
}
