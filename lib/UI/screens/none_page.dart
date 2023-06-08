import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../logic/util/internationalization.dart';

class NonePage extends StatefulWidget {
  final String name;
  NonePage({this.name});
  @override
  State<StatefulWidget> createState() => _NonePageSate();
}

class _NonePageSate extends State<NonePage> {
  static const htmlData = "<p>Hola Mundo</p>Este no es un texto";
  @override
  Widget build(BuildContext context) =>
      Center(child: Text(FLocalizations.of(context).getText("z9jlpsmq")));

  Widget createHtml() => Html(
      data: htmlData,
      style: {'html': Style(fontFamily: 'Ingram', fontSize: FontSize(8))});
}
