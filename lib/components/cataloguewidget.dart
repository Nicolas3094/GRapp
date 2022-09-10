import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:g_mcp/Models/catalogue.dart';
import 'package:g_mcp/Models/infostructure.dart';
import 'package:g_mcp/Models/project.dart';
import 'package:g_mcp/components/projectwidget%20.dart';
import 'package:g_mcp/components/swipeimage_widget.dart';
import 'package:g_mcp/util/flutter_theme.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import '../Models/imagen.dart';
import '../util/flutter_util.dart';
import 'data_category_widget.dart';
import 'loaderspinner.dart';

class CatalogueWidget extends StatefulWidget {
  final bool showDescription;
  final List<InfoStructure> structList;
  final int initIndex;

  CatalogueWidget({this.showDescription, this.structList, this.initIndex = 0});
  @override
  _CatalogueWidget createState() => _CatalogueWidget();
}

class _CatalogueWidget extends State<CatalogueWidget> {
  List<List<Imagen>> _dataimagen = [];
  bool _loading = true;
  int lenimgs;
  String _name;
  @override
  void initState() {
    _name = widget.showDescription ? "project" : "catalogue";
    lenimgs = widget.structList.length;
    getImages().whenComplete(() => setState(() => _loading = false));
    super.initState();
  }

  Future<void> getImages() async {
    for (var i = 0; i < lenimgs; i++) {
      List<Imagen> img0 =
          await FFAppState.getImgsProject(widget.structList[i].images);
      _dataimagen.add(img0);
    }
  }

  bool phone;
  bool tablet;
  bool tabletland;

  double pad;
  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    pad = tablet || tabletland ? 40.0 : 30.0;
    return _loading
        ? LoaderSpinner()
        : TransformerPageView(
            itemCount: lenimgs,
            scrollDirection: Axis.vertical,
            transformer: FFAppState.getTransformer(1),
            index: widget.initIndex,
            curve: Curves.easeInBack,
            itemBuilder: (context, i) {
              return phone || tablet
                  ? verticalView(
                      context, i, _dataimagen[i], widget.structList[i])
                  : horizontalView(i, _dataimagen[i]);
            });
  }

  Widget verticalView(BuildContext context, int index, List<Imagen> imglist,
      InfoStructure struct) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            flex: tablet || tabletland ? 4 : 2,
            child: SwipeImagesWidget(
              folder: struct.dir,
              imagenes: imglist,
            )),
        if (_name != "catalogue")
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [descriptionBtn(struct)],
            ),
          ),
        if (_name == "catalogue")
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [descriptionBtnCat(struct)],
            ),
          ),
        Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              width: MediaQuery.of(context).size.width,
              child: _name == "catalogue"
                  ? DataCategoryWidget(
                      actualCatg: struct,
                    )
                  : ProjectWidget(
                      project: struct,
                      numText: 0,
                    ),
            ))
      ],
    );
  }

  Widget descriptionBtnCat(Catalogue project) => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsetsDirectional.fromSTEB(tablet || tabletland ? 5 : 10,
              0, tablet || tabletland ? 5 : 10, 0),
          backgroundColor: Colors.black,
          minimumSize: tablet || tabletland ? Size(125, 35) : Size(50, 30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        onPressed: () => showDataAlertCat(project),
        child: Text(
          'Description',
          style: FlutterTheme.of(context)
              .bodyText2
              .override(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );

  void showDataAlertCat(Catalogue project) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(230, 255, 255, 255),
          contentPadding:
              EdgeInsets.only(top: pad, bottom: pad, left: pad, right: pad),
          content: Container(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.width *
                (tablet || tabletland ? 0.55 : 0.6),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: boldTitle(project.title)),
                      if (project.bod1 != " ") bodyInf(project.bod1),
                      if (project.bod2 != " ") bodyInf(project.bod2),
                      if (project.bod3 != " ") bodyInf(project.bod3),
                      if (project.bod4 != " ") bodyInf(project.bod4),
                    ]),
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
          style: FlutterTheme.of(context).bodyText1));
  Widget bodyInf(String dat) => Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 1.5, 0, 10),
      child: Text(
        "${dat}",
        textAlign: TextAlign.justify,
        style: FlutterTheme.of(context).bodyText1,
      ));
  Widget descriptionBtn(Project project) => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsetsDirectional.fromSTEB(tablet || tabletland ? 5 : 10,
              0, tablet || tabletland ? 5 : 10, 0),
          backgroundColor: Colors.black,
          minimumSize: tablet || tabletland ? Size(125, 35) : Size(50, 30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        onPressed: () => showDataAlert(project),
        child: Text(
          'Description',
          style: FlutterTheme.of(context)
              .bodyText2
              .override(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
  void showDataAlert(Project project) => showDialog(
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
                    child: ProjectWidget(numText: 2, project: project),
                  )
                ],
              ),
            ),
          ),
        );
      });

  Widget horizontalView(int index, List<Imagen> imglist) => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                child: SwipeImagesWidget(
                  folder: widget.structList[index].dir,
                  imagenes: imglist,
                )),
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                            child: _name == "catalogue"
                                ? DataCategoryWidget(
                                    actualCatg:
                                        FFAppState.getCatalogues()[index],
                                  )
                                : ProjectWidget(
                                    project: widget.structList[index],
                                    numText: 1,
                                  ))),
                    if (_name != "catalogue")
                      descriptionBtn(widget.structList[index])
                    else
                      descriptionBtnCat(widget.structList[index])
                  ],
                ),
              )),
        ],
      );

  Widget assetImg(BuildContext context, String path) {
    return Image.asset(path);
  }

  Widget cachedImg(String path) => CachedNetworkImage(
      imageUrl: path,
      fit: BoxFit.cover,
      placeholder: (context, url) => LoaderSpinner());
}
