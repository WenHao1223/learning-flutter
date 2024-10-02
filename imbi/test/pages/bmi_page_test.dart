import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imbi/pages/bmi_page.dart';

void main() {
  testWidgets(
      "Given weightInfoCard When user click + button Then weight increment by 1",
      (tester) async {
    // Arrange
    await tester.pumpWidget(
      CupertinoApp(
        home: BmiPage(),
      ),
    );
    var weightIncrementButton = find.byKey(const Key("weight_plus"));

    // Act
    await tester.tap(weightIncrementButton);
    await tester.pump();

    // Assert
    var text = find.text("161");
    expect(text, findsOneWidget);
  });

  testWidgets(
      "Given weightInfoCard When user click - button Then weight decrement by 1",
      (tester) async {
    // Arrange
    await tester.pumpWidget(
      CupertinoApp(
        home: BmiPage(),
      ),
    );
    var weightIncrementButton = find.byKey(const Key("weight_minus"));

    // Act
    await tester.tap(weightIncrementButton);
    await tester.pump();

    // Assert
    var text = find.text("159");
    expect(text, findsOneWidget);
  });
}
