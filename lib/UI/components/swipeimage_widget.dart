import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:g_mcp/data/Models/infostructure.dart';
import '../../logic/util/flutter_theme.dart';
import '../../logic/util/flutter_util.dart';
import '../../logic/util/internationalization.dart';
import 'body_text.dart';
import 'loaderspinner.dart';

class SwipeImagesWidget extends StatefulWidget {
  final InfoStructure dataStructure;
  const SwipeImagesWidget({Key key, this.dataStructure}) : super(key: key);
  @override
  _SwipeImagesState createState() => _SwipeImagesState();
}

class _SwipeImagesState extends State<SwipeImagesWidget> {
  int len;
  bool visible = true;
  GlobalKey<State> key = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    imageCache.clear();
  }

  bool phone;
  bool tablet;
  bool tabletland;
  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    len = widget.dataStructure.images.length;
    return ListView.builder(
        itemCount: len + 1,
        scrollDirection: Axis.vertical,
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemBuilder: (context, index) => index == len
            ? Container(child: customText(widget.dataStructure))
            : Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Container(
                    child: CacheNet(
                  widget.dataStructure.images[index],
                ))));
  }

  Widget customText(InfoStructure data) => !data.isHtml
      ? generalText(data)
      : Html(
          onLinkTap: (url, context, attributes, element) {
            launchURL(url);
          },
          data: FLocalizations.of(context).locale.languageCode == "es"
              ? data.descriptionESP
              : data.descriptionENG,
          style: {
              'body': Style(
                  fontFamily: FlutterTheme.of(context).bodyText3.fontFamily,
                  fontSize:
                      FontSize(FlutterTheme.of(context).bodyText3.fontSize),
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  lineHeight: LineHeight(1.5)),
              'span': Style(color: Colors.red)
            });

  Widget generalText(InfoStructure data) => BodyText(
        data: FLocalizations.of(context).locale.languageCode == "es"
            ? data.descriptionESP.replaceAll("\\n", "\n")
            : data.descriptionENG.replaceAll("\\n", "\n"),
      );

  Widget CacheNet(String image_url) => CachedNetworkImage(
        imageUrl: image_url,
        fit: BoxFit.cover,
        memCacheHeight: tablet || tabletland ? 700 : 400,
        memCacheWidth: tablet || tabletland ? 700 : 400,
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
