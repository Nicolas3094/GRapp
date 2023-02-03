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
      await ProjectService.isLoading();
      setState(() => displaySplashImage = false);
      _structures = ProjectService.getProjects();
    } else {
      var response = await CatalogueService.isLoading();
      if (!response) {
        setState(() => displaySplashImage = false);
        _structures = CatalogueService.getCatalogues();
      }
    }
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  double phone_project_condition(int index) {
    return (index == 4 ||
            index == 5 ||
            index == 12 ||
            index == 13 ||
            index == 14)
        ? 1
        : 1.7;
  }

  double phone_catalogue_condition(int index) {
    return (index == 2 ||
            index == 3 ||
            index == 4 ||
            index == 5 ||
            index == 8 ||
            index == 9 ||
            index == 14 ||
            index == 15 ||
            index == 17 ||
            index == 16 ||
            index == 19 ||
            index == 18 ||
            index == 22 ||
            index == 23 ||
            index == 24 ||
            index == 25 ||
            index == 26 ||
            index == 27 ||
            index == 28 ||
            index == 29)
        ? 2
        : 1.1;
  }

  double tablet_project_condition(int index) {
    return (index == 12 || index == 13 || index == 14) ? 1 : 1.8;
  }

  double tablet_catalogue_condition(int index) {
    return (index == 25) ? 1 : 2;
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
                    : widget.isProject
                        ? tablet_project_condition(index)
                        : tablet_catalogue_condition(index)),
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
            crossAxisCount: phone || phoneland
                ? 2
                : tablet
                    ? 4
                    : 7,
            itemCount:
                widget.isProject ? _structures.length : _structures.length,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
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
                              Text(
                                  "${i < 9 ? '0' : ''}${_structures[i].order}.",
                                  style: FlutterTheme.of(context).bodyText2),
                              Text("(${_structures[i].year.toString()})",
                                  style: FlutterTheme.of(context).bodyText2),
                            ],
                          )),
                      Flexible(
                          child: Text(
                        "${_structures[i].title}",
                        style: FlutterTheme.of(context).bodyText2,
                      )),
                    ],
                  ));
            },
          );
  }
}
