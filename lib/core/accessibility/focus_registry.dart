import 'package:flutter/material.dart';

/// This Registry is used to save the focusNode for a determinate key
/// And next can be used to get the FocusNode and assign it to a determinate widget and to call requestFocus()
/// usually used to give a focus on a specific widget when talkback/VoiceOver is active, this because flutter don't reload the widget-tree of semantic
/// and this cause that when a user do a navigation with a bottomNavigationBar the semantic don't change and remain on the menu when it should go
/// on the first element of the view loaded
///
/// I will try to found a good solution for auto-register a path when a navigation pattern is declare with the go_router navigation, otherwise is a good-luck for you :)
class FocusRegistry {
  final Map<String, FocusNode> _nodes = <String, FocusNode>{};

  void register(String key) {
    _nodes[key] = FocusNode();
  }

  FocusNode? get(String key) => _nodes[key];
}
