import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String data;
  BodyText({this.data});
  @override
  Widget build(BuildContext context) => Text(
        data,
        overflow: TextOverflow.clip,
      );
}
