import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations);

  static List<String> languages() => ['en', 'es'];

  String get languageCode => locale.languageCode;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.languageCode] ?? '';

  String getVariableText({
    String enText = '',
    String esText = '',
  }) =>
      [enText, esText][languageIndex] ?? '';
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      FFLocalizations.languages().contains(locale.languageCode);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    '4vb80p5u': {
      'en': 'Home',
      'es': '',
    },
  },
  // BIOPAGE
  {
    'z43j2gsn': {
      'en': 'Home',
      'es': '',
    },
  },
  // CATcero
  {
    'w1j9xq7t': {
      'en': 'Home',
      'es': '',
    },
  },
  // CATceroImgs
  {
    'rx0220np': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT1
  {
    'v4b9xhzw': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT2
  {
    'ozkeslzw': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT3
  {
    '7qqisvlq': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT4
  {
    'a7yefkbw': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT5
  {
    '55rjbm0a': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT6
  {
    '7qsb5rgd': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT7
  {
    'iozu4xeb': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT8
  {
    '6bc77o6t': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT9
  {
    'fdn1gjgi': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT10
  {
    'zkx5tiqg': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT11
  {
    'je44hh82': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT1Imgs
  {
    'nq2m240y': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT2Imgs
  {
    'ctcnzuk0': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT3Img
  {
    'e0jbxxxq': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT4Img
  {
    'rd6pshyz': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT5Img
  {
    'yd6tqxdg': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT6Img
  {
    '6uarzjsh': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT7Img
  {
    'acoxa0fn': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT8Img
  {
    'jxr63bv3': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT9Img
  {
    'sbidsodv': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT10Img
  {
    'hobrtn1g': {
      'en': 'Home',
      'es': '',
    },
  },
  // CAT11Img
  {
    'ohx1msah': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJECTSPG
  {
    'zimjlqc6': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ0Imgs
  {
    'k8r6lk7u': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ1Imgs
  {
    'n0hkerc2': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ2Imgs
  {
    'q47l5wyg': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ3Imgs
  {
    'fpt6b4we': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ4Imgs
  {
    'm7aze9v1': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ5Imgs
  {
    'd19rhzns': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ6Img
  {
    'kz544sx4': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ7Imgs
  {
    'f5wq4qyi': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ8Imgs
  {
    '6mqw5rsk': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ9Imgs
  {
    'mk2udxos': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ10Imgs
  {
    'sedtgjl7': {
      'en': 'Home',
      'es': '',
    },
  },
  // PROJ11Imgs
  {
    '1fpcn3mm': {
      'en': 'Home',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
