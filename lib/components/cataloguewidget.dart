import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:g_mcp/components/swipeimage_widget.dart';
import 'package:g_mcp/util/flutter_theme.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../Models/imagen.dart';
import '../util/flutter_util.dart';
import 'data_category_widget.dart';
import 'loaderspinner.dart';

class CatalogueWidget extends StatefulWidget {
  @override
  _CatalogueWidget createState() => _CatalogueWidget();
}

class _CatalogueWidget extends State<CatalogueWidget> {
  List<List<Imagen>> _dataimagen = [];
  bool _loading = true;
  int lenimgs = FFAppState.getCatalogues().length;

  @override
  void initState() {
    getImages().whenComplete(() => setState(() => _loading = false));

    super.initState();
  }

  Future<void> getImages() async {
    for (var i = 0; i < lenimgs; i++) {
      List<Imagen> img0 =
          await FFAppState.getImgsProject(FFAppState.getCatalogues()[i].images);
      _dataimagen.add(img0);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool phone = responsiveVisibility(context: context, phone: true);

    bool tablet = responsiveVisibility(context: context, tablet: true);

    return _loading
        ? LoaderSpinner()
        : TransformerPageView(
            itemCount: _dataimagen.length,
            scrollDirection: Axis.vertical,
            transformer: FFAppState.getTransformer(1),
            curve: Curves.easeInBack,
            itemBuilder: (context, i) => phone || tablet
                ? verticalView(context, _dataimagen[i], i)
                : horizontalView(i, _dataimagen[i]),
          );
  }

  Widget verticalView(BuildContext context, List<Imagen> imglist, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: SwipeImagesWidget(
                  folder: FFAppState.getCatalogues()[index].dir,
                  imagenes: imglist,
                ))
              ],
            )),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              width: MediaQuery.of(context).size.width,
              child: DataCategoryWidget(
                actualCatg: FFAppState.getCatalogues()[index],
              ),
            )),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [descriptionBtn()],
          ),
        )
      ],
    );
  }

  Widget descriptionBtn() => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        onPressed: () => showDataAlert(),
        child: Text(
          'Description',
          style: FlutterTheme.of(context).bodyText2.override(
                color: Colors.white,
              ),
        ),
      );
  void showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: Text(
              "Create ID",
              style: TextStyle(fontSize: 24.0),
            ),
            content: Container(
              height: 400,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Mension Your ID ",
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Id here',
                            labelText: 'ID'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Text(
                          "Submit",
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Note'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
                        ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
                        ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                        ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
                        'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                        ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget horizontalView(int index, List<Imagen> imglist) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: SwipeImagesWidget(
                folder: FFAppState.getCatalogues()[index].dir,
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
                          child: DataCategoryWidget(
                    actualCatg: FFAppState.getCatalogues()[index],
                  ))),
                  descriptionBtn()
                ],
              ),
            )),
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
