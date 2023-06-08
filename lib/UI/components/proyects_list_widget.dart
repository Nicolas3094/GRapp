import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:g_mcp/data/Models/infostructure.dart';
import 'package:g_mcp/index.dart';
import 'package:g_mcp/logic/blocs/catalogue/catalogue_bloc.dart';
import 'package:g_mcp/logic/blocs/projects/project_bloc.dart';
import '../../logic/util/flutter_theme.dart';
import '../../logic/util/flutter_util.dart';
import 'cataloguewidget.dart';
import 'loaderspinner.dart';

class ProyectsListWidget extends StatefulWidget {
  final bool isProject;
  const ProyectsListWidget({Key key, this.isProject}) : super(key: key);

  @override
  _ProyectsListWidget createState() => _ProyectsListWidget();
}

class _ProyectsListWidget extends State<ProyectsListWidget> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    imageCache.clear();
  }

  double phone_project_condition(int index) {
    return 1.1;
  }

  double phone_catalogue_condition(int index) {
    return (index == 6 ||
            index == 7 ||
            index == 10 ||
            index == 11 ||
            index == 14 ||
            index == 15 ||
            index == 17 ||
            index == 16 ||
            index == 19 ||
            index == 18)
        ? 1.9
        : 1.1;
  }

  double tablet_project_condition(int index) {
    return (index <= 3) ? 1.5 : 1.2;
  }

  double tablet_catalogue_condition(int index) {
    return (index <= 3 || (index <= 30 && index >= 20)) ? 1.1 : 2;
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
          return goNextScreen(i, state.projects);
        },
      );
    } else if (state is ProjectErrorState) {
      return Center(
        child: Text(state.error),
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
          return goNextScreen(i, state.catalogues);
        },
      );
    } else if (state is CatalogueErrorState) {
      return Center(
        child: Text(state.error),
      );
    } else {
      return Center(
        child: Text("Error"),
      );
    }
  }

  Widget goNextScreen(int i, List<InfoStructure> lst) => InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
              child: GenericPageWidget(
                  widg: CatalogueWidget(
                showDescription: widget.isProject,
                structList: lst[i],
                initIndex: i,
              ))),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (lst[i].images.length != 0)
            Container(
                child: CacheNet(lst[i].frontPage != -1
                    ? lst[i].images[lst[i].frontPage]
                    : "https://firebasestorage.googleapis.com/v0/b/gabrielricoestudio-48ad9.appspot.com/o/projects%2F2.%20LA%20CUCHARA%20Y%20EL%20LADRILLO%2Fportada%2Fportada.jpg?alt=media&token=426ac2f4-9057-4848-b560-2bbd6d6aefca")),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
              child: Row(
                children: [
                  Text("${i < 9 ? '0' : ''}${lst[i].order}.",
                      style: FlutterTheme.of(context).bodyText2),
                  Text("(${lst[i].year.toString()})",
                      style: FlutterTheme.of(context).bodyText2),
                ],
              )),
          Flexible(
              child: Text(
            "${lst[i].title}",
            style: FlutterTheme.of(context).bodyText2,
          )),
        ],
      ));
  Widget CacheNet(String image_url) => CachedNetworkImage(
        useOldImageOnUrlChange: false,
        imageUrl: image_url,
        fit: BoxFit.cover,
        memCacheHeight: 200,
        memCacheWidth: tablet ? 500 : 200,
        placeholder: (context, url) => Container(
            height: 50,
            width: 50,
            child: LoaderSpinner(
                color: Color.fromRGBO(0, 0, 0, 1), w: 50.0, h: 50.0)),
        errorWidget: (context, error, stacTrace) => Icon(Icons.error),
      );
}
