class Pet {
  final String name;
  final String animalType;
  final String breed;
  final String image;
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

  Pet copyWith({
    String? name,
    String? animalType,
    String? breed,
    String? image,
    double? age,
    double? price,
    bool? isAdopted,
  }) {
    return Pet(
      name: name ?? this.name,
      animalType: animalType ?? this.animalType,
      breed: breed ?? this.breed,
      image: image ?? this.image,
      age: age ?? this.age,
      price: price ?? this.price,
      isAdopted: isAdopted ?? this.isAdopted,
    );
  }
}