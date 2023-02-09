import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FLocalizations {
  FLocalizations(this.locale);

  final Locale locale;

  static FLocalizations of(BuildContext context) =>
      Localizations.of<FLocalizations>(context, FLocalizations);

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

class FLocalizationsDelegate extends LocalizationsDelegate<FLocalizations> {
  const FLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      FLocalizations.languages().contains(locale.languageCode);

  @override
  Future<FLocalizations> load(Locale locale) =>
      SynchronousFuture<FLocalizations>(FLocalizations(locale));

  @override
  bool shouldReload(FLocalizationsDelegate old) => false;
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    '4vb80p5u': {
      'en': 'Home',
      'es': 'Inicio',
    },
  },
  // Projects
  {
    'Projects': {
      'en': 'Projects',
      'es': 'Proyectos',
    },
  },
  // Catalogue
  {
    'w1j9xq7t': {
      'en': 'Catalogue',
      'es': 'Catalogo',
    },
  },
  // Bio
  {
    'rx0220np': {
      'en': 'Bio',
      'es': 'Bio',
    },
  },
  // AR
  {
    'v4b9xhzw': {
      'en': 'AR',
      'es': 'AR',
    },
  },
  // Collectors
  {
    'ozkeslzw': {
      'en': 'Collectors',
      'es': 'Coleccionistas',
    },
  },
  // Press
  {
    '7qqisvlq': {
      'en': 'Press',
      'es': 'Prensa',
    },
  },
  // Contact
  {
    'a7yefkbw': {
      'en': 'Contact',
      'es': 'Contacto',
    },
  },
  // UnusedSection
  {
    'z9jlpsmq': {
      'en':
          'This section will host collectible artworks that combine the real with the virtual.',
      'es':
          'Esta sección albergará piezas coleccionables que conjuntan lo real con lo virtual.',
    },
  },
].reduce((a, b) => a..addAll(b));
