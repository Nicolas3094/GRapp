import 'package:g_mcp/Models/catalogue.dart';
import 'package:g_mcp/Models/imagen.dart';
import 'package:flutter/material.dart';

import '../Models/project.dart';
import '../util/internationalization.dart';
import 'body_text.dart';
import 'cacheImage.dart';

class SwipeImagesWidget extends StatefulWidget {
  final Project project;
  final Catalogue catalogue;
  const SwipeImagesWidget({Key key, this.project = null, this.catalogue = null})
      : super(key: key);
  @override
  _SwipeImagesState createState() => _SwipeImagesState();
}

class _SwipeImagesState extends State<SwipeImagesWidget>
    with AutomaticKeepAliveClientMixin {
  PageController pageViewController;

  @override
  bool get wantKeepAlive => true;

  int len;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    len = widget.project != null
        ? widget.project.images.length
        : widget.catalogue.images.length;
    return ListView.builder(
        itemCount: len + 1,
        scrollDirection: Axis.vertical,
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        itemBuilder: (context, index) {
          if (index == len) {
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
                child: ImageCached(
                  image_url: widget.project != null
                      ? widget.project.images[index]
                      : widget.catalogue.images[index],
                ), //Image.asset(widget.folder + widget.imagenes[index].url)),
              ));
        });
  }

  Widget projectText() => BodyText(
        data: FFLocalizations.of(context).locale.languageCode == "es"
            ? widget.project.descriptionESP.replaceAll("\\n", "\n")
            : widget.project.descriptionENG.replaceAll("\\n", "\n"),
      );

  Widget catalogueText() => BodyText(
        data: FFLocalizations.of(context).locale.languageCode == "es"
            ? widget.catalogue.descriptionESP.replaceAll("\\n", "\n")
            : widget.catalogue.descriptionENG.replaceAll("\\n", "\n"),
      );
}
