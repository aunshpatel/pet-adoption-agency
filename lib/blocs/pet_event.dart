import '../models/pet_model.dart';

abstract class PetEvent {}

class FetchPets extends PetEvent {}

class AdoptPet extends PetEvent {
  final Pet pet;

  AdoptPet({required this.pet});
}
