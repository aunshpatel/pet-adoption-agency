import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pet_model.dart';
import '../widgets/consts.dart';

part 'pet_event.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  PetBloc() : super(PetInitial()) {
    on<LoadPets>((event, emit) async {
      emit(PetsLoading());
      try {
        List<Pet> pets = await _fetchPetData();
        emit(PetsLoaded(pets));
      } catch (e) {
        emit(PetError('Failed to load pets: $e'));
      }
    });

    on<AdoptPet>((event, emit) async {
      if (state is PetsLoaded) {
        List<Pet> updatedPets = List.from((state as PetsLoaded).pets);
        updatedPets[event.index].isAdopted = true;
        await _saveAdoptedPet(updatedPets[event.index]);
        emit(PetsUpdated(updatedPets));
      }
    });

    on<SearchPets>((event, emit) async {
      if (state is PetsLoaded) {
        List<Pet> allPets = await _fetchPetData();
        List<Pet> filteredPets;
        if (event.query.isEmpty) {
          filteredPets = allPets;
        } else {
          filteredPets = allPets.where((pet) => pet.name.toLowerCase().contains(event.query.toLowerCase())).toList();
        }
        emit(PetsLoaded(filteredPets));
      }
    });

    on<ShowAdoptedPets>((event, emit) async {
      if (state is PetsLoaded) {
        final List<Pet> adoptedPets = (state as PetsLoaded).pets.where((pet) => pet.isAdopted).toList();
        emit(PetsLoaded(adoptedPets));
      }
    });
  }

  Future<List<Pet>> _fetchPetData() async {
    List<Pet> initialPets = [
      Pet(name: 'Luna', animalType: 'Cat', breed: 'Ragdoll Cat', image: 'assets/images/ragdoll_cat.jpeg', age: 3, price: 200),
      Pet(name: 'Czar', animalType: 'Dog', breed: 'Siberian Husky', image: 'assets/images/siberian_husky.jpeg', age: 2, price: 400),
      Pet(name: 'Rocky', animalType: 'Dog', breed: 'French Bulldog', image: 'assets/images/french_bulldog.jpeg', age: 2.5, price: 250),
      Pet(name: 'Ginger', animalType: 'Dog', breed: 'Golden Retriever', image: 'assets/images/golden_retriever.jpg', age: 0.6, price: 350),
      Pet(name: 'Pluto', animalType: 'Dog', breed: 'Shih Tzu - Poodle Mix', image: 'assets/images/shihpoo.jpeg', age: 3, price: 225),
      Pet(name: 'Giggles', animalType: 'Cat', breed: 'Siamese Cat', image: 'assets/images/siamese_cat.jpeg', age: 1, price: 500),
      Pet(name: 'Rambo', animalType: 'Dog', breed: 'Great Dane', image: 'assets/images/great_dane.jpeg', age: 1.5, price: 300),
      Pet(name: 'Garfield', animalType: 'Cat', breed: 'Persian Cat', image: 'assets/images/persian_cat.jpeg', age: 0.5, price: 240),
      Pet(name: 'Missy', animalType: 'Cat', breed: 'British Shorthair', image: 'assets/images/british_shorthair.jpeg', age: 1, price: 300),
      Pet(name: 'Lightning', animalType: 'Cat', breed: 'Japanese Bobtail', image: 'assets/images/japanese_bobtail.jpeg', age: 2, price: 400),
    ];

    prefs = await SharedPreferences.getInstance();
    List<String> adoptedPetNames = prefs.getStringList('adoptedPets') ?? [];

    List<Pet> updatedPets = initialPets.map((pet) {
      return pet.copyWith(isAdopted: adoptedPetNames.contains(pet.name));
    }).toList();

    return updatedPets;
  }

  Future<void> _saveAdoptedPet(Pet pet) async {
    prefs = await SharedPreferences.getInstance();
    List<String> adoptedPetNames = prefs.getStringList('adoptedPets') ?? [];

    if (!adoptedPetNames.contains(pet.name)) {
      adoptedPetNames.add(pet.name);
      await prefs.setStringList('adoptedPets', adoptedPetNames);
    }
  }
}