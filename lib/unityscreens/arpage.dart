import 'package:g_mcp/Models/project.dart';

import 'package:flutter/material.dart';
import 'package:g_mcp/index.dart';
import 'package:g_mcp/unityscreens/single_ar_page.dart';

import '../components/loaderspinner.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import 'simple_screen.dart';

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
          int len;
          _arprojects = data.data as List<Project>;
          len = _arprojects.length;
          List<int> _items = List.generate(len, (i) => i);

          return Wrap(
            spacing: 11,
            runSpacing: 11,
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [
              for (var i in _items)
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.height / 4,
                  child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                              child: GenericPageWidget(
                                title: "AR",
                                widg: SingleARPageWidget(
                                  structt: _arprojects[i],
                                  initIndex: 3 - i,
                                ),
                              )),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                                  child: Image.asset(
                                      _arprojects[i].dir + "1.jpg"))),
                          Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
                              child: Row(
                                children: [
                                  Text((i + 1).toString() + ".",
                                      style:
                                          FlutterTheme.of(context).bodyText2),
                                  Text("(${_arprojects[i].year.toString()})",
                                      style:
                                          FlutterTheme.of(context).bodyText2),
                                ],
                              )),
                          Flexible(
                              child: Text(
                            "${_arprojects[i].title}",
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
    );
  }
}
