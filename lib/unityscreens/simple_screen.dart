import 'package:flutter/material.dart';
//import 'package:flutter_unity_widget/flutter_unity_widget.dart';
//import 'package:pointer_interceptor/pointer_interceptor.dart';

class SimpleScreen extends StatefulWidget {
  SimpleScreen({Key key}) : super(key: key);

  @override
  _SimpleScreenState createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  //UnityWidgetController _unityWidgetController;
  bool loading = true;
  @override
  void initState() {
    super.initState();
  }

  /*@override
  void dispose() {
    _height = 0.0;
    _unityWidgetController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Card(
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              /* Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: UnityWidget(
                  onUnityCreated: _onUnityCreated,
                  onUnityMessage: onUnityMessage,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  webUrl: 'http://localhost:6080',
                  useAndroidViewSurface: false,
                  borderRadius: BorderRadius.all(Radius.circular(70)),
                  placeholder: LoaderSpinner(),
                ),
              ),
              PointerInterceptor(
                  child: Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Card(
                  elevation: 10,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                        child: InkWell(
                          onTap: () => Navigator.pop(context, true),
                          child: Text(
                            "- AR",
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))*/
            ],
          )),
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  /*void _onUnityCreated(UnityWidgetController controller) {
    print("Entraaa");

    controller.resume();
    this._unityWidgetController = controller;
    Future.delayed(Duration(seconds: 5), () => LoadApplication());
  }

  void LoadApplication() {
    setState(() {
      loading = false;
      _height = 1.0;
    });
  }*/
}
