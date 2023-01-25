import 'dart:ui';

import 'package:g_mcp/Models/catalogue.dart';
import 'package:g_mcp/Models/infostructure.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:g_mcp/index.dart';
import 'package:g_mcp/services/catalogue_service.dart';

import '../services/project_service.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import 'cacheImage.dart';
import 'cataloguewidget.dart';

class ProyectsListWidget extends StatefulWidget {
  final bool isProject;
  const ProyectsListWidget({Key key, this.isProject}) : super(key: key);

  @override
  _ProyectsListWidget createState() => _ProyectsListWidget();
}

class _ProyectsListWidget extends State<ProyectsListWidget> {
  List<InfoStructure> _structures;
  bool displaySplashImage = true;
  int len = 0;

  _asyncMethod() async {
    if (widget.isProject) {
      if (ProjectService.getProjects().length == 0) {
        await ProjectService.fetchFirebase();
      }
      setState(() => _structures = ProjectService.getProjects());
    } else {
      if (CatalogueService.getCatalogues().length == 0) {
        await CatalogueService.fetchFirebase();
      }
      setState(() => _structures = CatalogueService.getCatalogues());
    }
    setState(() => displaySplashImage = false);
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  double phone_project_condition(int index) {
    return (index == 2 ||
            index == 3 ||
            index == 6 ||
            index == 7 ||
            index == 12 ||
            index == 13)
        ? 1
        : 1.7;
  }

  double phone_catalogue_condition(int index) {
    return (index == 2 ||
            index == 3 ||
            index == 6 ||
            index == 7 ||
            index == 8 ||
            index == 9 ||
            index == 12 ||
            index == 13 ||
            index == 16 ||
            index == 17 ||
            index == 18 ||
            index == 19 ||
            index == 22 ||
            index == 23 ||
            index == 24 ||
            index == 25)
        ? 2
        : 1.1;
  }

  @override
  Widget build(BuildContext context) {
    bool phone = responsiveVisibility(context: context, phone: true);

    bool tablet = responsiveVisibility(context: context, tablet: true);
    bool phoneland =
        responsiveVisibility(context: context, phoneLanspace: true);
    return displaySplashImage
        ? LoaderSpinner()
        : StaggeredGridView.countBuilder(
            staggeredTileBuilder: (index) => StaggeredTile.count(
                1,
                phone || phoneland
                    ? widget.isProject
                        ? phone_project_condition(index)
                        : phone_catalogue_condition(index)
                    : 1),
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            itemCount: _structures.length,
            itemBuilder: (_, i) {
              return InkWell(
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
                                structList: _structures[i],
                                initIndex: i,
                              ))),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (_structures[i].images.length != 0)
                        Container(
                            child: ImageCached(
                                image_url: _structures[i].images[0])),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
                          child: Row(
                            children: [
                              Text((i + 1).toString() + ".",
                                  style: FlutterTheme.of(context).bodyText2),
                              Text("(${_structures[i].year.toString()})",
                                  style: FlutterTheme.of(context).bodyText2),
                            ],
                          )),
                      Flexible(
                          child: Text(
                        "${_structures[i].title}",
                        style: FlutterTheme.of(context).bodyText2,
                        overflow: TextOverflow.clip,
                      )),
                    ],
                  ));
            },
          );
  }
}
