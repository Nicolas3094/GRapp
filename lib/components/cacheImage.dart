import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'loaderspinner.dart';

class ImageCached extends StatelessWidget {
  final String image_url;
  ImageCached({this.image_url});
  @override
  Widget build(BuildContext context) {
    return CacheNet();
  }

  Widget ExtededCache() => ExtendedImage.network(
        image_url,
        fit: BoxFit.cover,
        cache: true,
        enableMemoryCache: false,
        enableLoadState: false,
      );
  Widget CacheNet() => CachedNetworkImage(
        useOldImageOnUrlChange: false,
        imageUrl: image_url,
        fit: BoxFit.cover,
        memCacheHeight: 500,
        maxHeightDiskCache: 500,
        placeholder: (context, url) => Container(
            height: 50,
            width: 50,
            child: LoaderSpinner(
                color: Color.fromRGBO(0, 0, 0, 1), w: 50.0, h: 50.0)),
        errorWidget: (context, error, stacTrace) => Icon(Icons.error),
      );
}
