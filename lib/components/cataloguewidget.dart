import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:g_mcp/Models/infostructure.dart';
import 'package:g_mcp/components/projectwidget%20.dart';
import 'package:g_mcp/components/swipeimage_widget.dart';
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
        : verticalView(context, widget.initIndex, _dataimagen[widget.initIndex],
            widget.structList[widget.initIndex]);
  }

  Widget verticalView(BuildContext context, int index, List<Imagen> imglist,
      InfoStructure struct) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          width: MediaQuery.of(context).size.width,
          child: _name == "catalogue"
              ? DataCategoryWidget(
                  actualCatg: struct,
                )
              : ProjectWidget(
                  project: struct,
                  numText: 0,
                  index: index,
                ),
        ),
        Flexible(
            child: Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SwipeImagesWidget(
                  folder: struct.dir,
                  imagenes: imglist,
                  project: this._name == "project" ? struct : null,
                  catalogue: this._name == "catalogue" ? struct : null,
                ))),
      ],
    );
  }

  Widget assetImg(BuildContext context, String path) {
    return Image.asset(path);
  }

  Widget cachedImg(String path) => CachedNetworkImage(
      imageUrl: path,
      fit: BoxFit.cover,
      placeholder: (context, url) => LoaderSpinner());
}
