import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

export 'lat_lng.dart';
export '../app_state.dart';
export 'dart:math' show min, max;
export 'package:intl/intl.dart';
export 'package:page_transition/page_transition.dart';

T valueOrDefault<T>(T value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

String dateTimeFormat(String format, DateTime dateTime) {
  if (dateTime == null) {
    return '';
  }
  if (format == 'relative') {
    return timeago.format(dateTime);
  }
  return DateFormat(format).format(dateTime);
}

Future launchURL(String url) async {
  var uri = Uri.parse(url).toString();
  try {
    await launch(uri);
  } catch (e) {
    throw 'Could not launch $uri: $e';
  }
}

Future launEmail(String email, String subject, String body) async {
  final String EMAIL = Uri.encodeComponent(email);
  final String SUBJECT = Uri.encodeComponent(subject);
  final String BODY = Uri.encodeComponent(body);
  final Uri MAIL = Uri.parse("mailto:$EMAIL?subject=$SUBJECT&body=$BODY");
  await launch(MAIL.toString());
}

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isiOS => !kIsWeb && Platform.isIOS;
bool get isWeb => kIsWeb;

bool responsiveVisibility({
  @required BuildContext context,
  bool phone = false,
  bool phoneLanspace = false,
  bool tablet = false,
  bool tabletLandscape = false,
}) {
  final shortest = MediaQuery.of(context).size.shortestSide;
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  if (shortest < 479) {
    if (width > height) {
      return phoneLanspace ? true : false;
    }
    return phone ? true : false;
  } else {
    if (width > height) {
      return tabletLandscape ? true : false;
    }
    return tablet ? true : false;
  }
}

void setAppLanguage(BuildContext context, String language) =>
    MyApp.of(context).setLocale(Locale(language, ''));

void setDarkModeSetting(BuildContext context, ThemeMode themeMode) =>
    MyApp.of(context).setThemeMode(themeMode);

void showSnackbar(
  BuildContext context,
  String message, {
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (loading)
            Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: Container(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          Text(message),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
