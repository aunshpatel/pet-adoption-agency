import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String name;
  final String image;
  final String animalType;
  final String breed;
  final double age;
  final double price;
  bool isAdopted;

  Pet({
    required this.name,
    required this.animalType,
    required this.breed,
    required this.image,
    required this.age,
    required this.price,
    this.isAdopted = false,
  });

  @override
  List<Object?> get props => [name, animalType, breed, image, age, price, isAdopted];
}