import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:g_mcp/index.dart';
import 'package:g_mcp/logic/blocs/catalogue/catalogue_bloc.dart';
import 'package:g_mcp/logic/blocs/projects/project_bloc.dart';
import 'package:g_mcp/main.dart';

import '../../data/Models/infostructure.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import 'cacheImage.dart';
import 'cataloguewidget.dart';
import 'loaderspinner.dart';

class ProyectsListWidget extends StatefulWidget {
  final bool isProject;
  const ProyectsListWidget({Key key, this.isProject}) : super(key: key);

  @override
  _ProyectsListWidget createState() => _ProyectsListWidget();
}

class _ProyectsListWidget extends State<ProyectsListWidget> {
  bool displaySplashImage = true;
  int len = 0;

  _asyncMethod() async {}

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
            index == 13 ||
            index == 14)
        ? 1
        : 1.8;
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

  bool phone;

  bool tablet;
  bool phoneland;
  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    phoneland = responsiveVisibility(context: context, phoneLanspace: true);
    return widget.isProject
        ? BlocBuilder<ProjectBloc, ProjectStates>(builder: (context, state) {
            return loadedProject(context, state);
          })
        : BlocBuilder<CatalogueBloc, CatalogueStates>(
            builder: (context, state) {
            return loadedCatalogue(context, state);
          });
  }

  Widget loadedProject(BuildContext context, ProjectStates state) {
    if (state is ProjectLoadingSate) {
      return LoaderSpinner();
    } else if (state is ProjectLoadedState) {
      return StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => StaggeredTile.count(
            1,
            phone || phoneland
                ? phone_project_condition(index)
                : tablet_project_condition(index)),
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        crossAxisCount: phone || phoneland
            ? 2
            : tablet
                ? 4
                : 7,
        itemCount: state.projects.length,
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
                            structList: state.projects[i],
                            initIndex: i,
                          ))),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (state.projects[i].images.length != 0)
                    Container(
                        child: ImageCached(
                            image_url: state.projects[i].images[0])),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
                      child: Row(
                        children: [
                          Text("${i < 9 ? '0' : ''}${state.projects[i].order}.",
                              style: FlutterTheme.of(context).bodyText2),
                          Text("(${state.projects[i].year.toString()})",
                              style: FlutterTheme.of(context).bodyText2),
                        ],
                      )),
                  Flexible(
                      child: Text(
                    "${state.projects[i].title}",
                    style: FlutterTheme.of(context).bodyText2,
                  )),
                ],
              ));
        },
      );
    } else {
      return Center(
        child: Text("Error"),
      );
    }
  }

  Widget loadedCatalogue(BuildContext context, CatalogueStates state) {
    if (state is CatalogueLoadingSate) {
      return LoaderSpinner();
    } else if (state is CatalogueLoadedState) {
      return StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => StaggeredTile.count(
            1,
            phone || phoneland
                ? phone_catalogue_condition(index)
                : tablet_catalogue_condition(index)),
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        crossAxisCount: phone || phoneland
            ? 2
            : tablet
                ? 4
                : 7,
        itemCount: state.catalogues.length,
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
                            structList: state.catalogues[i],
                            initIndex: i,
                          ))),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (state.catalogues[i].images.length != 0)
                    Container(
                        child: ImageCached(
                            image_url: state.catalogues[i].images[0])),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
                      child: Row(
                        children: [
                          Text(
                              "${i < 9 ? '0' : ''}${state.catalogues[i].order}.",
                              style: FlutterTheme.of(context).bodyText2),
                          Text("(${state.catalogues[i].year.toString()})",
                              style: FlutterTheme.of(context).bodyText2),
                        ],
                      )),
                  Flexible(
                      child: Text(
                    "${state.catalogues[i].title}",
                    style: FlutterTheme.of(context).bodyText2,
                  )),
                ],
              ));
        },
      );
    } else {
      return Center(
        child: Text("Error"),
      );
    }
  }
}
