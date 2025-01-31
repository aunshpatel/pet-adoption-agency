// // import '../models/pet_model.dart';
// //
// // abstract class PetEvent {}
// //
// // class FetchPets extends PetEvent {}
// //
// // class AdoptPet extends PetEvent {
// //   final Pet pet;
// //
// //   AdoptPet({required this.pet});
// // }
// //
// // class SearchPets extends PetEvent {
// //   final String query;
// //
// //   const SearchPets({required this.query});
// //
// //   @override
// //   List<Object?> get props => [query];
// // }
// //
// // class ShowAdoptedPets extends PetEvent {}
//
// import 'package:equatable/equatable.dart';
//
// import '../models/pet_model.dart';
//
// abstract class PetEvent extends Equatable {
//   const PetEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// // Event to load all pets (initial or refresh)
// class LoadPets extends PetEvent {}
//
// // Event to adopt a specific pet
// class AdoptPet extends PetEvent {
//   final int index; // Consider using Pet object instead of index for clarity
//
//   const AdoptPet(this.index);
//
//   @override
//   List<Object?> get props => [index];
// }
//
// // Event to search pets based on a query
// class SearchPets extends PetEvent {
//   final String query;
//
//   const SearchPets({required this.query});
//
//   @override
//   List<Object?> get props => [query];
// }
//
// // Event to show only adopted pets
// class ShowAdoptedPets extends PetEvent {}


// import 'package:equatable/equatable.dart';
//
// import '../models/pet_model.dart';
//
// abstract class PetEvent extends Equatable {
//   const PetEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// // Event to load all pets (initial or refresh)
// class LoadPets extends PetEvent {}
//
// // Event to adopt a specific pet
// class AdoptPet extends PetEvent {
//   final int index; // Consider using Pet object instead of index for clarity
//
//   const AdoptPet(this.index);
//
//   @override
//   List<Object?> get props => [index];
// }
//
// // Event to search pets based on a query
// class SearchPets extends PetEvent {
//   final String query;
//
//   const SearchPets({required this.query});
//
//   @override
//   List<Object?> get props => [query];
// }
//
// // Event to show only adopted pets
// class ShowAdoptedPets extends PetEvent {}

import 'package:equatable/equatable.dart';

import '../models/pet_model.dart';

abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object?> get props => [];
}

// Event to load all pets (initial or refresh)
class LoadPets extends PetEvent {}

// Event to adopt a specific pet
class AdoptPet extends PetEvent {
  final int index; // Consider using Pet object instead of index for clarity

  const AdoptPet(this.index);

  @override
  List<Object?> get props => [index];
}

// Event to search pets based on a query
class SearchPets extends PetEvent {
  final String query;

  const SearchPets({required this.query});

  @override
  List<Object?> get props => [query];
}

// Event to show only adopted pets
class ShowAdoptedPets extends PetEvent {}