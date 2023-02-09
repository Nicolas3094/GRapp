import 'package:flutter/material.dart';

import '../../util/flutter_theme.dart';

class BodyText extends StatelessWidget {
  final String data;
  BodyText({this.data});
  @override
  Widget build(BuildContext context) => Text(data,
      overflow: TextOverflow.clip, style: FlutterTheme.of(context).bodyText3);
}
