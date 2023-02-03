import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:g_mcp/Models/catalogue.dart';
import 'package:flutter/material.dart';

import '../Models/project.dart';
import '../util/flutter_util.dart';
import '../util/internationalization.dart';
import 'body_text.dart';
import 'loaderspinner.dart';

class SwipeImagesWidget extends StatefulWidget {
  final Project project;
  final Catalogue catalogue;
  const SwipeImagesWidget({Key key, this.project = null, this.catalogue = null})
      : super(key: key);
  @override
  _SwipeImagesState createState() => _SwipeImagesState();
}

class _SwipeImagesState extends State<SwipeImagesWidget> {
  int len;
  bool visible = true;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        //add more logic for your case
        if (_controller.position.userScrollDirection ==
                ScrollDirection.reverse &&
            visible) {
          visible = false;
          setState(() {});
        }
        if (_controller.position.userScrollDirection ==
                ScrollDirection.forward &&
            !visible) {
          visible = true;
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool phone;
  bool tablet;
  bool tabletland;
  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    len = widget.project != null
        ? widget.project.images.length
        : widget.catalogue.images.length;
    return ListView.builder(
        itemCount: len,
        scrollDirection: Axis.vertical,
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        cacheExtent: 2000,
        itemBuilder: (context, index) {
          if (index == len - 1) {
            return Container(
                child:
                    widget.project != null ? projectText() : catalogueText());
          }

          return visible
              ? Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: CacheNet(
                    widget.project != null
                        ? widget.project.images[index]
                        : widget.catalogue.images[index],
                  ))
              : Container();
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
  Widget CacheNet(String image_url) => CachedNetworkImage(
        useOldImageOnUrlChange: false,
        imageUrl: image_url,
        fit: BoxFit.cover,
        memCacheHeight: tablet || tabletland ? 900 : 700,
        maxHeightDiskCache: tablet || tabletland ? 900 : 700,
        maxWidthDiskCache: tablet || tabletland ? 900 : 700,
        placeholder: (context, url) => Container(
            height: 50,
            width: 50,
            child: LoaderSpinner(
                color: Color.fromRGBO(0, 0, 0, 1), w: 50.0, h: 50.0)),
        errorWidget: (context, error, stacTrace) => Icon(Icons.error),
      );

  Widget NotCache(String url) => Image.network(
        url,
        fit: BoxFit.cover,
      );
}
