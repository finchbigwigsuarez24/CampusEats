
import 'package:flutter_test/flutter_test.dart';
import 'package:campuseats/app.dart';

void main() {
  testWidgets('CampusEats app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusEatsApp());

    expect(find.text('CampusEats'), findsOneWidget);
    expect(find.text('Welcome back!'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
