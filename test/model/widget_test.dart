import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:realtime_innovations_assignment2/employeeList.dart';

group(){
  // BEGINNING OF NEW CONTENT
  testWidgets('Testing if ListView shows up', (tester) async {
    await tester.pumpWidget((EmpList(title: 'testing',)));
    expect(find.byType(ListView), findsOneWidget);
  });
  // END OF NEW CONTENT

  testWidgets('Testing Scrolling', (tester) async {
    await tester.pumpWidget(EmpList(title: 'testing',));
    expect(find.text('Item 0'), findsOneWidget);
    await tester.fling(
      find.byType(ListView),
      const Offset(0, -200),
      3000,
    );
    await tester.pumpAndSettle();
    expect(find.text('Item 0'), findsNothing);
  });
}