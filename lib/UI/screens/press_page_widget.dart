import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_mcp/logic/blocs/press/press_bloc.dart';

import '../../data/Models/press_model.dart';
import '../../logic/util/flutter_theme.dart';
import '../../logic/util/flutter_util.dart';
import '../../logic/util/internationalization.dart';
import '../components/loaderspinner.dart';

class PressPageWidget extends StatefulWidget {
  const PressPageWidget({Key key}) : super(key: key);

  @override
  _PressPageWidgetState createState() => _PressPageWidgetState();
}

class _PressPageWidgetState extends State<PressPageWidget> {
  bool phone;
  bool phoneland;

  @override
  Widget build(BuildContext context) {
    phone = responsiveVisibility(context: context, phone: true);
    phoneland = responsiveVisibility(context: context, phoneLanspace: true);
    return BlocBuilder<PressBloc, PressStates>(builder: (context, state) {
      if (state is PressLoadingSate) {
        return LoaderSpinner();
      } else if (state is PressErrorState) {
        return Center(
          child: Text(state.error),
        );
      } else if (state is PressLoadedState) {
        return phone || phoneland
            ? mobileV(context, state.press)
            : mobileV(context, state.press);
      } else {
        return Center(
          child: Text("Error"),
        );
      }
    });
  }

  Widget mobileV(BuildContext context, List<Press> pressTitles) => SafeArea(
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < pressTitles.length; i++)
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, phone || phoneland ? 21 : 31, 0),
                          child: Text(
                              "${i < 9 ? 0 : ''}${pressTitles[i].order}",
                              style: FlutterTheme.of(context).pressText)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pressTitles[i].title,
                              style: FlutterTheme.of(context).pressText,
                            ),
                            Text(
                              FLocalizations.of(context).locale.languageCode ==
                                      "es"
                                  ? pressTitles[i].fechaESP
                                  : pressTitles[i].fechaENG,
                              style: FlutterTheme.of(context).pressText,
                            )
                          ],
                        ),
                      ),
                      Container(
                          alignment: Alignment.topCenter,
                          child: IconButton(
                            iconSize: 32,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            constraints: BoxConstraints(),
                            onPressed: () async {
                              await launchURL(pressTitles[i].link);
                            },
                            icon: Image.asset("assets/images/Reveresd.png"),
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
            ],
          ),
        ),
      );

  Widget tabletV(BuildContext context, PressStates state) => Container();
}
