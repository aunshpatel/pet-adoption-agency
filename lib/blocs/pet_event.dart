part of 'pet_bloc.dart';

abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object?> get props => [];
}

class LoadPets extends PetEvent {}

class AdoptPet extends PetEvent {
  final int index;

  const AdoptPet(this.index);

  @override
  List<Object?> get props => [index];
}

class SearchPets extends PetEvent {
  final String query;

  const SearchPets({required this.query});

  @override
  List<Object?> get props => [query];
}

class ShowAdoptedPets extends PetEvent {}

abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object?> get props => [];
}

class PetInitial extends PetState {}

class PetsLoading extends PetState {}

class PetsLoaded extends PetState {
  final List<Pet> pets;

  const PetsLoaded(this.pets);

  @override
  List<Object?> get props => [pets];
}

class PetsUpdated extends PetState {
  final List<Pet> pets;

  const PetsUpdated(this.pets);

  @override
  List<Object?> get props => [pets];
}

class PetError extends PetState {
  final String message;

  const PetError(this.message);

  @override
  List<Object?> get props => [message];
}