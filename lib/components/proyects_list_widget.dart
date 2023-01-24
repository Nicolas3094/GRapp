import 'dart:ui';

import 'package:g_mcp/Models/catalogue.dart';
import 'package:g_mcp/Models/infostructure.dart';
import 'package:g_mcp/Models/project.dart';

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

  List<Project> _projects;
  List<Catalogue> _catalogues;

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

  @override
  Widget build(BuildContext context) {
    bool phone = responsiveVisibility(context: context, phone: true);

    bool tablet = responsiveVisibility(context: context, tablet: true);
    bool phoneland =
        responsiveVisibility(context: context, phoneLanspace: true);

    return displaySplashImage
        ? LoaderSpinner()
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              spacing: (phone || phoneland ? 3 : 11),
              runSpacing: (phone || phoneland ? 15 : 11),
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              children: [
                for (var i = 0; i < (_structures.length); i++)
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
                                child: Row(
                                  children: [
                                    Text((i + 1).toString() + ".",
                                        style:
                                            FlutterTheme.of(context).bodyText2),
                                    Text("(${_structures[i].year.toString()})",
                                        style:
                                            FlutterTheme.of(context).bodyText2),
                                  ],
                                )),
                            Flexible(
                                child: Text(
                              "${_structures[i].title}",
                              style: FlutterTheme.of(context).bodyText2,
                              overflow: TextOverflow.clip,
                            )),
                          ],
                        )),
                  ),
              ],
            ));
  }
}
