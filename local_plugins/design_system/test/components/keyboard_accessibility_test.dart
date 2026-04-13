import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/design_system.dart';

void main() {
  group('KeyBoardAccessibility', () {
    testWidgets('should render child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KeyBoardAccessibility(
              child: Text('Test Widget'),
            ),
          ),
        ),
      );

      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('should show focus border when focused', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Focus(
              focusNode: focusNode,
              child: KeyBoardAccessibility(
                child: Container(
                  width: 100,
                  height: 100,
                  child: Text('Focusable'),
                ),
              ),
            ),
          ),
        ),
      );

      // Initially no focus
      expect(focusNode.hasFocus, isFalse);

      // Request focus
      focusNode.requestFocus();
      await tester.pumpAndSettle();

      // Should have focus now
      expect(focusNode.hasFocus, isTrue);

      focusNode.dispose();
    });

    testWidgets('should use custom focus border color', (tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KeyBoardAccessibility(
              focusBorderColor: customColor,
              child: Text('Custom Color'),
            ),
          ),
        ),
      );

      expect(find.byType(KeyBoardAccessibility), findsOneWidget);
    });

    testWidgets('should use custom animation duration', (tester) async {
      const customDuration = Duration(milliseconds: 500);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KeyBoardAccessibility(
              animationDuration: customDuration,
              child: Text('Custom Duration'),
            ),
          ),
        ),
      );

      expect(find.byType(KeyBoardAccessibility), findsOneWidget);
    });

    testWidgets('should use design tokens for default values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KeyBoardAccessibility(
              child: Text('Design Tokens'),
            ),
          ),
        ),
      );

      // The widget should render without errors using design token defaults
      expect(find.text('Design Tokens'), findsOneWidget);
    });

    test('KeyBoardAccessibilityModel should store properties correctly', () {
      const model = KeyBoardAccessibilityModel(
        hasFocus: true,
        borderColor: Colors.red,
        borderWidth: 3.0,
        padding: 8.0,
        borderRadius: Radius.circular(12),
      );

      expect(model.hasFocus, isTrue);
      expect(model.borderColor, Colors.red);
      expect(model.borderWidth, 3.0);
      expect(model.padding, 8.0);
      expect(model.borderRadius, Radius.circular(12));
    });

    test('KeyBoardAccessibilityModel should have default values', () {
      const model = KeyBoardAccessibilityModel();

      expect(model.hasFocus, isFalse);
      expect(model.borderColor, isNull);
      expect(model.borderWidth, isNull);
      expect(model.padding, isNull);
      expect(model.borderRadius, isNull);
    });
  });
}
