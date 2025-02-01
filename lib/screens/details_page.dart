import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:confetti/confetti.dart';
import '../blocs/pet_bloc.dart';
import '../models/pet_model.dart';
import '../widgets/consts.dart';

class DetailsPage extends StatefulWidget {
  final Pet pet;
  const DetailsPage({Key? key, required this.pet}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: const Text(
          'Pet Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// **Pet Image with Hero Animation**
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Hero(
                tag: 'petImage - ${widget.pet.name}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: PhotoView(
                      imageProvider: AssetImage(widget.pet.image),
                      backgroundDecoration: const BoxDecoration(color: Colors.transparent),

                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// **Pet Details Card**
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow('Name:', widget.pet.name),
                    _buildDetailRow('Animal Type:', widget.pet.animalType),
                    _buildDetailRow('Breed:', widget.pet.breed),
                    _buildDetailRow('Age:', '${widget.pet.age} years old'),
                    _buildDetailRow('Price:', '\$${widget.pet.price}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// **Adoption Button**
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pet.isAdopted ? Colors.grey : Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: widget.pet.isAdopted ? null : () async {
                setState(() => _confettiController.play());

                if (context.read<PetBloc>().state is PetsLoaded) {
                  final currentState = context.read<PetBloc>().state as PetsLoaded;
                  if (currentState.pets.contains(widget.pet)) {
                    final index = currentState.pets.indexOf(widget.pet);
                    context.read<PetBloc>().add(AdoptPet(index));
                  } else {
                    commonAlertBox(context, 'WARNING!', 'Pet not found!');
                  }
                }

                await Future.delayed(const Duration(seconds: 1));
                commonAlertBox(context, 'Adoption Successful!', 'You have adopted ${widget.pet.name}!');
              },
              child: Text(
                widget.pet.isAdopted ? 'Already Adopted' : 'Click to Adopt Me',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            /// **Confetti Celebration**
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 30,
              gravity: 0.2,
            ),
          ],
        ),
      ),
    );
  }

  /// **Reusable Detail Row**
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}


