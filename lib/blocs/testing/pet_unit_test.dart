import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_adoption_center/blocs/pet_bloc.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PetBloc petBloc;

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'adoptedPets': [],
    });

    petBloc = PetBloc();
  });

  tearDown(() async {
    await petBloc.close();
  });

  test('Pet search functionality filters pets correctly', () async {
    final stateStream = <PetState>[];
    final subscription = petBloc.stream.listen(stateStream.add);

    petBloc.add(LoadPets());

    await expectLater(
      petBloc.stream,
      emitsInOrder([
        isA<PetsLoading>(),
        isA<PetsLoaded>(),
      ]),
    );

    expect(stateStream.last, isA<PetsLoaded>());
    final petsBeforeSearch = (stateStream.last as PetsLoaded).pets;
    print("Pets before search: ${petsBeforeSearch.map((pet) => pet.name).toList()}");

    petBloc.add(SearchPets(query: 'Luna'));

    await expectLater(
      petBloc.stream,
      emitsInOrder([isA<PetsLoaded>()]),
    );

    expect(stateStream.last, isA<PetsLoaded>());
    final petsAfterSearch = (stateStream.last as PetsLoaded).pets;
    print("Pets after search: ${petsAfterSearch.map((pet) => pet.name).toList()}");

    expect(petsAfterSearch, isNotEmpty);
    expect(petsAfterSearch.every((pet) => pet.name.toLowerCase().contains('luna')), isTrue);

    await subscription.cancel();
  }, timeout: Timeout(Duration(seconds: 30)));
}
