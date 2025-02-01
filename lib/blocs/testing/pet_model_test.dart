import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../../models/pet_model.dart';
import '../../screens/details_page.dart';

void main() {
  //WIDGET TESTING
  testWidgets('Pet details are correctly displayed', (WidgetTester tester) async {
    // Create the pet instance
    final pet = Pet(
      name: 'Pluto',
      animalType: 'Dog',
      breed: 'Shih Tzu - Poodle Mix',
      image: 'assets/images/shihpoo.jpeg',
      age: 3,
      price: 225,
    );

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: DetailsPage(pet: pet)));
    expect(find.text('Pluto'), findsOneWidget);
    expect(find.text('Shih Tzu - Poodle Mix'), findsOneWidget);
    expect(find.text('\$ 225.0'), findsOneWidget);
    expect(find.text('3.0 years old'), findsOneWidget);
  });
}