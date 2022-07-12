import 'package:flutter/material.dart';
import 'package:g_mcp/util/flutter_util.dart';

class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool phone = responsiveVisibility(context: context, phone: true);
    bool phonel = responsiveVisibility(context: context, phoneLanspace: true);
    return IconButton(
        iconSize: phone || phonel ? 22 : 32,
        onPressed: () async => await Navigator.pop(context, true),
        icon: const Icon(Icons.arrow_back_sharp));
  }
}
//await Navigator.pop(context, true);

