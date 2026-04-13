import 'package:flutter/cupertino.dart';
import 'package:localization/generated/app_localizations.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
