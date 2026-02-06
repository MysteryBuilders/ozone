import 'package:flutter/material.dart';

abstract class LocalizationEvent {}

class ChangeLocale extends LocalizationEvent {
  final Locale locale;
  final BuildContext context;

  ChangeLocale(this.locale, this.context);
}

class DefaultLocale extends LocalizationEvent {
  final Locale locale;
  final BuildContext context;

  DefaultLocale(this.locale, this.context);
}


