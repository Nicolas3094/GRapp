import 'package:flutter/material.dart';

class LoaderSpinner extends StatefulWidget {
  final Color color;
  final double h;
  final double w;
  LoaderSpinner({Key key, this.color, this.h = 70, this.w = 70})
      : super(key: key);
  @override
  _LoaderSpinner createState() => new _LoaderSpinner();
}

class _LoaderSpinner extends State<LoaderSpinner>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: AnimatedBuilder(
        animation: animationController,
        child: Container(
          height: widget.h,
          width: widget.w,
          child: Image.asset('assets/images/GR_LOGO.png'),
        ),
        builder: (BuildContext context, Widget _widget) {
          return Transform.rotate(
            angle: (-1) * animationController.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }

  Widget spinnerLoader() => Container(
          child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: CircularProgressIndicator(
                  color: widget.color == null
                      ? Color.fromRGBO(0, 0, 0, 1)
                      : widget.color,
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(widget.color),
                ),
                height: widget.h == null ? 50.0 : widget.h,
                width: widget.w == null ? 50.0 : widget.w,
              )
            ]),
      ));
}
