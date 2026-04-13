import 'package:flutter/material.dart';
import 'package:booking_app/core/manager/routing/route_manager.dart';

/// Manager for showing/hiding loading indicators
///
/// This is a singleton that manages the global loading state
/// and can show/hide loading overlays in the app
///
/// Note: Uses the global NavigatorKey from route_manager, no need to manually set context
class LoadingManager {
  LoadingManager._internal();

  static final LoadingManager _instance = LoadingManager._internal();
  factory LoadingManager() => _instance;

  int _loadingCount = 0;
  OverlayEntry? _overlayEntry;

  /// Get current loading count
  int get loadingCount => _loadingCount;

  /// Check if loading is currently shown
  bool get isLoading => _loadingCount > 0;

  /// Show loading indicator
  ///
  /// Multiple calls will increment the counter
  /// The loader will only hide when all calls to hideLoading are made
  void showLoading() {
    _loadingCount++;

    if (_loadingCount == 1) {
      _showOverlay();
    }
  }

  /// Hide loading indicator
  ///
  /// Decrements the counter. Only removes the overlay when counter reaches 0
  void hideLoading() {
    if (_loadingCount > 0) {
      _loadingCount--;
    }

    if (_loadingCount == 0) {
      _hideOverlay();
    }
  }

  /// Force hide loading (reset counter)
  void forceHide() {
    _loadingCount = 0;
    _hideOverlay();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black54,
        child: const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(Navigate.currentContext).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
