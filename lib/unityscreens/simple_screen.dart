import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:g_mcp/util/flutter_util.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import '../components/backbtn.dart';
import '../components/loaderspinner.dart';
import 'dart:io';

class SimpleScreen extends StatefulWidget {
  SimpleScreen({Key key}) : super(key: key);

  @override
  _SimpleScreenState createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  UnityWidgetController _unityWidgetController;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(milliseconds: 3000),
        () => setState((() {
              loading = false;
              if (!FFAppState.getFirstSplash() && Platform.isIOS) {
                FFAppState.setFirstSplash();
              }
            })));
  }

  @override
  void dispose() {
    _unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: UnityWidget(
                onUnityCreated: _onUnityCreated,
                onUnityMessage: onUnityMessage,
                onUnitySceneLoaded: onUnitySceneLoaded,
                // webUrl: 'http://localhost:6080',
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
              child: Container(
                  color: Color.fromARGB(0, 0, 0, 0),
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          senToUnityScene("pause");
                          Navigator.pop(context, true);
                        },
                        child: BackBtn(),
                      ),
                      GestureDetector(
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/menuicon.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Text("Reset")
                            ],
                          ),
                          onTap: () => senToUnityScene("loader")),
                    ],
                  )),
            )),
            if (loading && !FFAppState.getFirstSplash())
              Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: LoaderSpinner(h: 150, w: 150),
                  )),
          ],
        ));
  }

  void onUnityMessage(message) {
    // print('Received message from unity: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    //print('Received scene loaded from unity: ${scene.name}');
    //print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(UnityWidgetController controller) {
    this._unityWidgetController = controller;
    if (FFAppState.getFirstSplash()) {
      senToUnityScene("resume");

      senToUnityScene("loader");
    }
  }

// Communcation from Flutter to Unity
  void senToUnityScene(String key) {
    _unityWidgetController.postMessage(
      'ExitController',
      'ReloadGame',
      key,
    );
  }
}
