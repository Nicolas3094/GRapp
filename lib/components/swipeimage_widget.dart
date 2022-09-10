import 'package:cached_network_image/cached_network_image.dart';
import 'package:g_mcp/Models/imagen.dart';
import 'package:g_mcp/components/loaderspinner.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import '../util/flutter_util.dart';
import 'package:flutter/material.dart';

class SwipeImagesWidget extends StatefulWidget {
  final List<Imagen> imagenes;
  final String folder;
  const SwipeImagesWidget({Key key, this.imagenes, this.folder})
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
    return TransformerPageView(
      loop: false,
      scrollDirection: Axis.horizontal,
      curve: Curves.easeInBack,
      transformer: FFAppState.getTransformer(3),
      itemCount: widget.imagenes.length,
      itemBuilder: (context, index) => InteractiveViewer(
          minScale: 0.5,
          maxScale: 4,
          child: Image.asset(widget.folder + widget.imagenes[index].url)),
    );
  }

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
