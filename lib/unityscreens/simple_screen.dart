import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../components/backbtn.dart';
import '../components/loaderspinner.dart';
import '../util/flutter_theme.dart';

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
        body: Card(
            margin: const EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
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
                  child: Container(
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 40, 20, 10),
                            child: InkWell(
                                onTap: () => Navigator.pop(context, true),
                                child: BackBtn()),
                          ),
                        ],
                      )),
                ))
              ],
            )));
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    print('Received scene loaded from unity: ${scene.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(UnityWidgetController controller) {
    controller.resume();
    this._unityWidgetController = controller;
    Future.delayed(Duration(seconds: 5), () => LoadApplication());
  }

  void LoadApplication() {
    setState(() {
      loading = false;
    });
  }
}
