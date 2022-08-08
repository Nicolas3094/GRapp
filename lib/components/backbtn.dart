import 'package:flutter/material.dart';

class BackBtn extends StatelessWidget {
  final double size;
  final Color cl;
  BackBtn({this.size = 32, this.cl = Colors.black});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: size,
      onPressed: () async => await Navigator.pop(context, true),
      icon: const Icon(Icons.arrow_back_sharp),
      color: cl,
    );
  }
}
