import 'package:flutter/material.dart';
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
    pad = tablet || tabletland ? 70.0 : 30.0;
    return _loading
        ? LoaderSpinner()
        : TransformerPageView(
            itemCount: lenimgs,
            scrollDirection: Axis.vertical,
            transformer: FFAppState.getTransformer(1),
            index: widget.initIndex,
            curve: Curves.easeInBack,
            itemBuilder: (context, i) => phone || tablet
                ? verticalView(context, _dataimagen[i], widget.structList[i])
                : horizontalView(i, _dataimagen[i]),
          );
  }

  Widget verticalView(
          BuildContext context, List<Imagen> imglist, InfoStructure struct) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              flex: tablet || tabletland ? 3 : 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: SwipeImagesWidget(
                    folder: struct.dir,
                    imagenes: imglist,
                  ))
                ],
              )),
          Expanded(
              flex: 1,
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
              )),
          if (widget.showDescription)
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [descriptionBtn(struct)],
              ),
            )
        ],
      );

  Widget descriptionBtn(Project project) => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        onPressed: () => showDataAlert(project),
        child: Text(
          'Description',
          style: FlutterTheme.of(context).bodyText2.override(
                color: Colors.white,
              ),
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
            height: MediaQuery.of(context).size.width * 0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 0, 0, tablet || tabletland ? 100 : 50),
                    child: ProjectWidget(numText: 1, project: project),
                  ),
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                  ],
                ),
              )),
        ],
      );

  Widget assetImg(BuildContext context, String path) {
    return Image.asset(path);
  }

 
}
