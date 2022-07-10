import 'package:flutter/material.dart';

class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 42,
        onPressed: () async => await Navigator.pop(context, true),
        icon: const Icon(Icons.arrow_back_sharp));
  }
}
//await Navigator.pop(context, true);

