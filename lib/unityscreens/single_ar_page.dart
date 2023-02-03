import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:g_mcp/Models/infostructure.dart';
import 'package:g_mcp/Models/project.dart';
import 'package:g_mcp/index.dart';
import '../components/loaderspinner.dart';
import '../util/flutter_theme.dart';
import '../util/flutter_util.dart';

class SingleARPageWidget extends StatefulWidget {
  final InfoStructure structt;
  final int initIndex;
  SingleARPageWidget({this.structt, this.initIndex = 0});
  @override
  _SingleARPageWidget createState() => _SingleARPageWidget();
}

class _SingleARPageWidget extends State<SingleARPageWidget> {
  int lenimgs;
  @override
  void initState() {
    super.initState();
  }

  bool phone;
  bool tablet;
  bool tabletland;

  double pad;
  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    pad = tablet || tabletland ? 40.0 : 30.0;
    return verticalView(context, widget.structt);
  }

  Widget verticalView(BuildContext context, InfoStructure struct) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
          width: MediaQuery.of(context).size.width,
          child: principalInfo(context, struct, false),
        ),
        Container(
          height: 260,
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
          child: Text(
            FFLocalizations.of(context).locale.languageCode == "es"
                ? struct.dataESP
                : struct.dataENG,
            style: FlutterTheme.of(context).bodyText3,
          ),
        ),
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                navBtn(
                    FFLocalizations.of(context).locale.languageCode == "es"
                        ? "EXPERIENCIA"
                        : "EXPERIENCE",
                    SimpleScreen(
                      sceneID: widget.initIndex,
                    ),
                    context)
              ],
            )),
        Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(struct.dir + "1.jpg"))),
      ],
    );
  }

  Widget navBtn(String name, Widget fn, BuildContext context) => TextButton(
        onPressed: (() => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => fn)))),
        child: Container(
          alignment: Alignment.center,
          height: 44,
          width: 124,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.black),
          ),
          child: Text(name, style: FlutterTheme.of(context).title1),
        ),
      );

  Widget assetImg(BuildContext context, String path) {
    return Image.asset(path);
  }

  Widget principalInfo(BuildContext context, Project project, bool bold) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
          child: Text(
            "${project.year.toString()}",
            style: FlutterTheme.of(context).bodyText1.override(
                fontStyle: bold ? FontStyle.normal : FontStyle.italic,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ),
        Flexible(
            child: Container(
                width: 552,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "0${widget.initIndex}. ${project.title}",
                      overflow: TextOverflow.clip,
                      style: FlutterTheme.of(context).bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "${project.year_place.replaceAll("\\n", "\n")}",
                      overflow: TextOverflow.clip,
                      style: FlutterTheme.of(context).bodyText1,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ))),
      ],
    );
  }

  Widget cachedImg(String path) => CachedNetworkImage(
      imageUrl: path,
      fit: BoxFit.cover,
      placeholder: (context, url) => LoaderSpinner());
}
