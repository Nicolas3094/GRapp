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
