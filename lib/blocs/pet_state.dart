import '../models/pet_model.dart';

abstract class PetState {}

class PetInitial extends PetState {}

class PetsLoading extends PetState {}

class PetsLoaded extends PetState {
  final List<Pet> pets;

  PetsLoaded({required this.pets});
}

class PetError extends PetState {
  final String message;

  PetError({required this.message});
}

class PetAdopted extends PetState {
  final Pet adoptedPet;

  PetAdopted({required this.adoptedPet});
}
