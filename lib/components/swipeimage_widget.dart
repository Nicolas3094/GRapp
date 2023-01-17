import 'package:cached_network_image/cached_network_image.dart';
import 'package:g_mcp/Models/catalogue.dart';
import 'package:g_mcp/Models/imagen.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:flutter/material.dart';

import '../Models/project.dart';
import 'body_text.dart';

class SwipeImagesWidget extends StatefulWidget {
  final Project project;
  final Catalogue catalogue;
  final List<Imagen> imagenes;
  final String folder;
  const SwipeImagesWidget(
      {Key key,
      this.imagenes,
      this.folder,
      this.project = null,
      this.catalogue = null})
      : super(key: key);
  @override
  _SwipeImagesState createState() => _SwipeImagesState();
}

class _SwipeImagesState extends State<SwipeImagesWidget>
    with AutomaticKeepAliveClientMixin {
  PageController pageViewController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        itemCount: widget.imagenes.length + 1,
        scrollDirection: Axis.vertical,
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        itemBuilder: (context, index) {
          if (index == widget.imagenes.length) {
            return Flexible(
                child: Container(
                    child: widget.project != null
                        ? projectText()
                        : catalogueText()));
          }
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4,
                child: Image.asset(widget.folder + widget.imagenes[index].url)),
          );
        });
  }

  Widget projectText() => BodyText(
        data: widget.project.descriptionENG,
      );

  Widget catalogueText() => BodyText(
        data: widget.catalogue.descriptionESP,
      );

  Widget cachedImg(String path) => CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.contain,
        placeholder: (context, url) => Container(
            height: 50,
            width: 50,
            child: LoaderSpinner(
                color: Color.fromRGBO(0, 0, 0, 1), w: 50.0, h: 50.0)),
        errorWidget: (context, error, stacTrace) => Icon(Icons.error),
      );
}
