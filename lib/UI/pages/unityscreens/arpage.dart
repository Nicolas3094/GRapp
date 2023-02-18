import 'package:g_mcp/Models/Description.dart';
import 'package:g_mcp/Models/DescriptionAR.dart';

import 'package:flutter/material.dart';
import 'package:g_mcp/UI/pages/unityscreens/single_ar_page.dart';
import 'package:g_mcp/index.dart';
import 'package:g_mcp/services/arProjects_service.dart';

import '../../../util/flutter_theme.dart';
import '../../../util/flutter_util.dart';
import '../../../util/internationalization.dart';
import '../../components/cacheImage.dart';
import '../../components/loaderspinner.dart';

class ARPageWidget extends StatefulWidget {
  const ARPageWidget({Key key}) : super(key: key);
  @override
  _ARPageWidget createState() => _ARPageWidget();
}

class _ARPageWidget extends State<ARPageWidget> {
  List<DescriptionAR> _arprojects;
  Description _descriptionAR = null;
  bool phone;
  bool tablet;
  bool tabletland;
  bool load = true;
  double pad;
  void initState() {
    _asyncMethod();
    super.initState();
  }

  _asyncMethod() async {
    _descriptionAR = await FFAppState.readJsonARDescription();
    await ARProjectService.fetchFirebase();
    _arprojects = ARProjectService.getProjects();
    setState(() => load = false);
  }

  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    tabletland = responsiveVisibility(context: context, tabletLandscape: true);
    tablet = responsiveVisibility(context: context, tablet: true);
    return load
        ? LoaderSpinner()
        : phone || tablet
            ? verticalView()
            : horizontalView();
  }

  Widget horizontalView() => SingleChildScrollView(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            if (_descriptionAR != null)
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: Text(
                    FLocalizations.of(context).locale.languageCode == "es"
                        ? _descriptionAR.descriptionESP
                        : _descriptionAR.descriptionENG,
                    style: FlutterTheme.of(context).bodyText2,
                  )),
            Container(
                width: (MediaQuery.of(context).size.width / 2),
                height: MediaQuery.of(context).size.height,
                child: BuilderImages())
          ]));

  Widget verticalView() => SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            if (_descriptionAR != null)
              Container(
                  width: phone ? MediaQuery.of(context).size.width : 632,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Text(
                    FLocalizations.of(context).locale.languageCode == "es"
                        ? _descriptionAR.descriptionESP
                        : _descriptionAR.descriptionENG,
                    style: FlutterTheme.of(context).bodyText2,
                  )),
            Container(
                width: phone ? MediaQuery.of(context).size.width : 632,
                child: BuilderImages())
          ]));

  Widget BuilderImages() {
    return Wrap(
      spacing: tablet
          ? 10
          : tabletland
              ? 1
              : phone
                  ? 1
                  : 10,
      runSpacing: 1,
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      children: [
        for (var i = 0; i < _arprojects.length; i++)
          Container(
            width: MediaQuery.of(context).size.width *
                (tablet
                    ? 0.17
                    : tabletland
                        ? 0.2
                        : phone
                            ? 0.4
                            : 0.14),
            height: MediaQuery.of(context).size.height *
                (tablet
                    ? 0.25
                    : tabletland
                        ? 0.4
                        : phone
                            ? 0.28
                            : 0.6),
            child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                        child: GenericPageWidget(
                          title: "AR",
                          widg: SingleARPageWidget(
                            structt: _arprojects[i],
                            initIndex: i,
                          ),
                        )),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: i == 0 || i == 2 ? 202 : 144,
                        child: ImageCached(
                          image_url: _arprojects[i].images[0],
                        )),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
                        child: Row(
                          children: [
                            Text("0${i + 1}.",
                                style: FlutterTheme.of(context).bodyText2),
                            Text("(${_arprojects[i].year.toString()})",
                                style: FlutterTheme.of(context).bodyText2),
                          ],
                        )),
                    Flexible(
                        child: Text(
                      "${_arprojects[i].title}",
                      style: FlutterTheme.of(context).bodyText2,
                      overflow: TextOverflow.fade,
                    )),
                  ],
                )),
          ),
      ],
    );
    ;
  }
}
