import 'package:imbi/main.dart' as app;

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:integration_test/integration_test.dart";


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("end-to-end app test", () {
    // Arrange
    var weightIncrementButton = find.byKey(const Key("weight_plus"));
    var ageIncrementButton = find.byKey(const Key("age_plus"));
    var calculateBmiButton = find.byType(CupertinoButton);

    testWidgets(
      "Given app is ran When height, age data input and calculateBmiButton pressed Then correct BMI returned",
      (tester) async {
        // Arrange
        // app.main();
        await tester.pumpWidget(const app.MyApp());
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));

        // Act
        await tester.tap(weightIncrementButton);
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));
        
        await tester.tap(ageIncrementButton);
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));
        
        await tester.tap(calculateBmiButton);
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));

        final resultText = find.text("Normal");

        // Assert
        expect(resultText, findsOneWidget);
      },
    );
  });
}
