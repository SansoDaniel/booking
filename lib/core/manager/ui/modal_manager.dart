import 'dart:async';
import 'package:flutter/material.dart' as material;
import 'package:booking_app/core/manager/routing/route_manager.dart';

/// Modal state representation
class ModalState {
  final String id;
  final material.Widget content;
  final ModalConfig config;
  final DateTime openedAt;
  bool isVisible;

  ModalState({
    required this.id,
    required this.content,
    required this.config,
    required this.openedAt,
    this.isVisible = true,
  });

  ModalState copyWith({
    String? id,
    material.Widget? content,
    ModalConfig? config,
    DateTime? openedAt,
    bool? isVisible,
  }) {
    return ModalState(
      id: id ?? this.id,
      content: content ?? this.content,
      config: config ?? this.config,
      openedAt: openedAt ?? this.openedAt,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

/// Configuration for modal behavior
class ModalConfig {
  final bool barrierDismissible;
  final material.Color? barrierColor;
  final String? barrierLabel;
  final bool useSafeArea;
  final bool useRootNavigator;
  final material.RouteSettings? routeSettings;
  final material.Offset? anchorPoint;
  final bool isScrollControlled;
  final double? elevation;
  final material.ShapeBorder? shape;
  final material.Clip? clipBehavior;
  final material.BoxConstraints? constraints;
  final material.Color? backgroundColor;
  final bool enableDrag;
  final bool showDragHandle;
  final material.AnimationController? transitionAnimationController;

  const ModalConfig({
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    this.useSafeArea = true,
    this.useRootNavigator = false,
    this.routeSettings,
    this.anchorPoint,
    this.isScrollControlled = false,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.backgroundColor,
    this.enableDrag = true,
    this.showDragHandle = false,
    this.transitionAnimationController,
  });

  /// Default configuration for bottom sheets
  static const ModalConfig bottomSheet = ModalConfig(
    isScrollControlled: true,
    enableDrag: true,
    showDragHandle: true,
  );

  /// Default configuration for dialogs
  static const ModalConfig dialog = ModalConfig(
    barrierDismissible: true,
    useSafeArea: true,
  );

  /// Default configuration for full-screen modals
  static const ModalConfig fullScreen = ModalConfig(
    barrierDismissible: false,
    useSafeArea: false,
    isScrollControlled: true,
  );
}

/// Manager for handling modal dialogs and bottom sheets with stack support
///
/// Features:
/// - Stack-based modal management (LIFO)
/// - Automatic restoration of previous modals
/// - State preservation when modal is hidden
/// - Support for both dialogs and bottom sheets
/// - Custom configurations per modal
/// - Event stream for modal state changes
class ModalManager {
  ModalManager._internal();

  static final ModalManager _instance = ModalManager._internal();
  factory ModalManager() => _instance;

  final List<ModalState> _modalStack = [];
  final _modalController = StreamController<List<ModalState>>.broadcast();
  bool _isTransitioning = false;

  /// Stream of modal stack changes
  Stream<List<ModalState>> get modalStream => _modalController.stream;

  /// Get current modal stack (read-only)
  List<ModalState> get modalStack => List.unmodifiable(_modalStack);

  /// Check if any modal is currently open
  bool get hasOpenModals => _modalStack.isNotEmpty;

  /// Get the currently visible modal
  ModalState? get currentModal =>
      _modalStack.isEmpty ? null : _modalStack.last;

  /// Get total number of modals in stack
  int get modalCount => _modalStack.length;

  /// Show a modal (dialog or bottom sheet)
  ///
  /// If another modal is already open, it will be hidden (but not closed)
  /// and will be automatically restored when this modal is closed
  ///
  /// Returns the modal ID for later reference
  Future<T?> showModal<T>({
    required material.Widget content,
    ModalConfig? config,
    String? id,
    bool isBottomSheet = false,
  }) async {
    // Set default config based on modal type
    final modalConfig = config ??
        (isBottomSheet ? ModalConfig.bottomSheet : const ModalConfig());

    // Generate unique ID if not provided
    final modalId = id ?? 'modal_${DateTime.now().millisecondsSinceEpoch}';

    // Check if modal with same ID already exists
    if (_modalStack.any((m) => m.id == modalId)) {
      throw Exception('Modal with ID $modalId already exists in stack');
    }

    // If there's a current modal, hide it (don't close)
    if (_modalStack.isNotEmpty && !_isTransitioning) {
      await _hideCurrentModal();
    }

    // Create modal state
    final modalState = ModalState(
      id: modalId,
      content: content,
      config: modalConfig,
      openedAt: DateTime.now(),
      isVisible: true,
    );

    // Add to stack
    _modalStack.add(modalState);
    _notifyListeners();

    // Show the modal
    _isTransitioning = true;
    T? result;

    try {
      if (isBottomSheet) {
        result = await _showBottomSheet<T>(modalState);
      } else {
        result = await _showDialog<T>(modalState);
      }
    } finally {
      _isTransitioning = false;
    }

    // Remove from stack when closed
    await closeModal(modalId);

    return result;
  }

  /// Show a dialog
  Future<T?> showDialog<T>({
    required material.Widget content,
    ModalConfig? config,
    String? id,
  }) {
    return showModal<T>(
      content: content,
      config: config,
      id: id,
      isBottomSheet: false,
    );
  }

  /// Show a bottom sheet
  Future<T?> showBottomSheet<T>({
    required material.Widget content,
    ModalConfig? config,
    String? id,
  }) {
    return showModal<T>(
      content: content,
      config: config,
      id: id,
      isBottomSheet: true,
    );
  }

  /// Internal method to show dialog
  Future<T?> _showDialog<T>(ModalState modalState) async {
    final config = modalState.config;

    // Use Flutter's showDialog (not our showDialog method)
    return await material.showDialog<T>(
      context: Navigate.currentContext,
      barrierDismissible: config.barrierDismissible,
      barrierColor: config.barrierColor,
      barrierLabel: config.barrierLabel,
      useSafeArea: config.useSafeArea,
      useRootNavigator: config.useRootNavigator,
      routeSettings: config.routeSettings,
      anchorPoint: config.anchorPoint,
      builder: (context) => _buildModalContent(modalState),
    ) as Future<T?>;
  }

  /// Internal method to show bottom sheet
  Future<T?> _showBottomSheet<T>(ModalState modalState) async {
    final config = modalState.config;

    return material.showModalBottomSheet<T>(
      context: Navigate.currentContext,
      isScrollControlled: config.isScrollControlled,
      useRootNavigator: config.useRootNavigator,
      isDismissible: config.barrierDismissible,
      enableDrag: config.enableDrag,
      showDragHandle: config.showDragHandle,
      backgroundColor: config.backgroundColor,
      elevation: config.elevation,
      shape: config.shape,
      clipBehavior: config.clipBehavior,
      constraints: config.constraints,
      barrierColor: config.barrierColor,
      useSafeArea: config.useSafeArea,
      routeSettings: config.routeSettings,
      transitionAnimationController: config.transitionAnimationController,
      builder: (context) => modalState.content,
    );
  }

  /// Build modal content with wrapper
  material.Widget _buildModalContent(ModalState modalState) {
    return material.Dialog(
      backgroundColor: modalState.config.backgroundColor,
      elevation: modalState.config.elevation,
      shape: modalState.config.shape,
      clipBehavior: modalState.config.clipBehavior ?? material.Clip.none,
      child: modalState.content,
    );
  }

  /// Hide current modal without closing it
  Future<void> _hideCurrentModal() async {
    if (_modalStack.isEmpty) return;

    final currentModal = _modalStack.last;
    currentModal.isVisible = false;

    // Close the modal UI
    material.Navigator.of(Navigate.currentContext, rootNavigator: currentModal.config.useRootNavigator)
        .pop();

    _notifyListeners();
  }

  /// Close modal by ID
  Future<void> closeModal(String id, {dynamic result}) async {
    final index = _modalStack.indexWhere((m) => m.id == id);
    if (index == -1) return;

    // Remove from stack
    _modalStack.removeAt(index);
    _notifyListeners();

    // If this was the visible modal and there are modals below, restore the previous one
    if (index == _modalStack.length && _modalStack.isNotEmpty && !_isTransitioning) {
      await _restorePreviousModal();
    }
  }

  /// Close the current (top) modal
  Future<void> closeCurrentModal({dynamic result}) async {
    if (_modalStack.isEmpty) return;
    await closeModal(_modalStack.last.id, result: result);
  }

  /// Close all modals
  Future<void> closeAllModals() async {
    while (_modalStack.isNotEmpty) {
      await closeCurrentModal();
    }
  }

  /// Restore the previous modal (internal use)
  Future<void> _restorePreviousModal() async {
    if (_modalStack.isEmpty) return;

    final previousModal = _modalStack.last;
    previousModal.isVisible = true;

    _isTransitioning = true;

    try {
      // Re-show the previous modal
      if (_isBottomSheetConfig(previousModal.config)) {
        await _showBottomSheet(previousModal);
      } else {
        await _showDialog(previousModal);
      }
    } finally {
      _isTransitioning = false;
    }
  }

  /// Check if config is for bottom sheet
  bool _isBottomSheetConfig(ModalConfig config) {
    return config.isScrollControlled || config.enableDrag || config.showDragHandle;
  }

  /// Get modal by ID
  ModalState? getModal(String id) {
    try {
      return _modalStack.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Check if modal exists in stack
  bool hasModal(String id) {
    return _modalStack.any((m) => m.id == id);
  }

  /// Get all modal IDs in stack (from bottom to top)
  List<String> get modalIds => _modalStack.map((m) => m.id).toList();

  /// Notify listeners of stack changes
  void _notifyListeners() {
    if (!_modalController.isClosed) {
      _modalController.add(List.unmodifiable(_modalStack));
    }
  }

  /// Dispose resources
  void dispose() {
    _modalController.close();
    _modalStack.clear();
  }

  /// Debug: Print current stack
  void debugPrintStack() {
    print('=== Modal Stack (${_modalStack.length} modals) ===');
    for (var i = 0; i < _modalStack.length; i++) {
      final modal = _modalStack[i];
      print('[$i] ${modal.id} - visible: ${modal.isVisible} - opened: ${modal.openedAt}');
    }
    print('=====================================');
  }
}
