import 'package:flutter/material.dart';
import 'package:g_mcp/Models/project.dart';
import 'package:g_mcp/components/swipeimage_widget.dart';
import 'package:g_mcp/index.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../Models/imagen.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';
import 'data_category_widget.dart';
import 'loaderspinner.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;
  const ProjectWidget({Key key, this.project}) : super(key: key);

  @override
  _ProjectWidget createState() => _ProjectWidget();
}

class _ProjectWidget extends State<ProjectWidget> {
  final String name = "PROJECTS";
  final double fontitle = 32;
  final double fontitle2 = 26;
  bool _tablet;
  bool _tabletl;
  final double fontsz = 18;
  List<Widget> renderWidgets;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _tablet = responsiveVisibility(context: context, tablet: true);
      _tabletl = responsiveVisibility(context: context, tabletLandscape: true);
    });
    List<Imagen> imglist;

    renderWidgets = [
      VerticalView(context, imglist, widget.project),
    ];
    if (!(widget.project.bod1 == widget.project.bod2 &&
        widget.project.bod2 == widget.project.bod3 &&
        widget.project.bod3 == widget.project.bod4 &&
        widget.project.bod4 == " ")) {
      renderWidgets.add(secondaryInfo(context, widget.project));
    }
    return TransformerPageView(
        scrollDirection: Axis.horizontal,
        curve: Curves.easeInBack,
        transformer: FFAppState.getTransformer(1),
        itemCount: renderWidgets.length + widget.project.images.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
              future: FFAppState.getImgsProject(widget.project.images),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Icon(Icons.error);
                } else if (snapshot.hasData) {
                  imglist = snapshot.data as List<Imagen>;
                  for (Imagen img in imglist) {
                    renderWidgets
                        .add(assetImg(context, widget.project.dir + img.url));
                  }
                  return renderWidgets[index];
                } else {
                  return LoaderSpinner();
                }
              });
        });
  }

  Widget principalInfo(BuildContext context, Project project) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Text(
            "${project.title}",
            textAlign: TextAlign.center,
            style: FlutterTheme.of(context)
                .subtitle1
                .override(useGoogleFonts: false, fontSize: fontitle),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Text(
            "${project.lugar != " " ? project.lugar : ""}\n${project.subtitulo != " " ? project.subtitulo : ""}",
            style:
                FlutterTheme.of(context).title1.override(fontSize: fontitle2),
            textAlign: TextAlign.center,
          ),
        ),
        if (project.cuerpo != " ")
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0,
                _tablet
                    ? 80
                    : _tabletl
                        ? 50
                        : 0,
                0,
                0),
            child: Text(
              "${project.cuerpo}",
              style: FlutterTheme.of(context).bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0,
                _tablet
                    ? 80
                    : _tabletl
                        ? 50
                        : 0,
                0,
                0),
            child: InkWell(
              onTap: () => launchURL(project.web),
              child: Text(
                "${project.web}",
                style: FlutterTheme.of(context).bodyText1,
                textAlign: TextAlign.center,
              ),
            )),
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
                style: FlutterTheme.of(context).bodyText1,
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
            if (project.tit1 != " ") boldTitle(project.tit1),
            if (project.bod1 != " ") bodyInf(project.bod1),
            if (project.tit2 != " ") boldTitle(project.tit2),
            if (project.bod2 != " ") bodyInf(project.bod2),
            if (project.tit3 != " ") boldTitle(project.tit3),
            if (project.bod3 != " ") bodyInf(project.bod3),
            if (project.tit4 != " ") boldTitle(project.tit4),
            if (project.bod4 != " ") bodyInf(project.bod4),
            if (project.web1 != " ") checkWeb(project.web1),
            if (project.web2 != " ") checkWeb(project.web2),
            if (project.web3 != " ") checkWeb(project.web3),
            if (project.web4 != " ") checkWeb(project.web4),
          ],
        ));
  }

  Widget VerticalView(
          BuildContext context, List<Imagen> imglist, Project project) =>
      Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    child: principalInfo(context, project)),
              )
            ],
          ),
        ],
      );

  Widget HorizontalView(
          BuildContext context, int index, List<Imagen> imglist) =>
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300),
                          child: GenericPageWidget(
                            title: "${name}",
                            widg: SwipeImagesWidget(
                              folder: FFAppState.getCatalogues()[index].dir,
                              imagenes:
                                  FFAppState.getCatalogues()[index].images,
                            ),
                          ),
                        ));
                  },
                  child: assetImg(context,
                      FFAppState.getCatalogues()[index].dir + imglist[0].url)),
            ),
          ),
          Expanded(
              child: DataCategoryWidget(
            actualCatg: FFAppState.getCatalogues()[index],
          ))
        ],
      );

  Widget assetImg(BuildContext context, String path) {
    bool tablet = responsiveVisibility(context: context, tablet: true);
    return Image.asset(
      path,
      height: tablet ? 500 : 1000,
      width: tablet ? 600 : 600,
    );
  }
}
