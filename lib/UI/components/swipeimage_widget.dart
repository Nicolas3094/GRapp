import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';

import '../../data/Models/catalogue.dart';
import '../../data/Models/project.dart';
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
  GlobalKey<State> key = new GlobalKey();
  static final customCacheManager = CacheManager(Config('customCacheKey',
      stalePeriod: const Duration(days: 1), maxNrOfCacheObjects: 20));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
        itemCount: len + 1,
        scrollDirection: Axis.vertical,
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        cacheExtent: 2000,
        itemBuilder: (context, index) {
          if (index == len) {
            return Container(
                child:
                    widget.project != null ? projectText() : catalogueText());
          }

          return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: CacheNet(
                widget.project != null
                    ? widget.project.images[index]
                    : widget.catalogue.images[index],
              ));
        });
  }

  Widget projectText() => BodyText(
        data: FLocalizations.of(context).locale.languageCode == "es"
            ? widget.project.descriptionESP.replaceAll("\\n", "\n")
            : widget.project.descriptionENG.replaceAll("\\n", "\n"),
      );

  Widget catalogueText() => BodyText(
        data: FLocalizations.of(context).locale.languageCode == "es"
            ? widget.catalogue.descriptionESP.replaceAll("\\n", "\n")
            : widget.catalogue.descriptionENG.replaceAll("\\n", "\n"),
      );
  Widget CacheNet(String image_url) => CachedNetworkImage(
        cacheManager: customCacheManager,
        key: UniqueKey(),
        useOldImageOnUrlChange: false,
        imageUrl: image_url,
        fit: BoxFit.cover,
        //memCacheHeight: tablet || tabletland ? 900 : 700,
        //maxHeightDiskCache: tablet || tabletland ? 900 : 700,
        //maxWidthDiskCache: tablet || tabletland ? 900 : 1000,
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
