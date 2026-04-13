import 'package:localization/localization.dart';
import 'package:project_architecture/core/manager/routing/route_manager.dart';
import 'package:toastification/toastification.dart';

class ToastManager {
  ToastManager();

  final AppLocalizations _localizations = Navigate.currentContext.localizations;

  void show() {
    toastification.show();
  }

  void showWarning() {
    toastification.show();
  }

  void showError() {
    toastification.show();
  }
}
