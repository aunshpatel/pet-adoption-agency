import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import '../blocs/pet_block.dart';
import '../models/pet_model.dart';
import 'package:confetti/confetti.dart';

import '../widgets/consts.dart';

class DetailsPage extends StatefulWidget {
  final Pet pet;
  const DetailsPage({Key? key, required this.pet}) : super(key: key);


  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with SingleTickerProviderStateMixin {
  bool _isAdopted = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  /*Path drawStar(Size size) {
    // Method to convert degrees to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }*/

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'petImage - ${widget.pet.name}',
                  child: ClipRRect(
                      child:SizedBox(
                        height: 300,
                        child: PhotoView(
                          imageProvider: AssetImage(widget.pet.image),
                          backgroundDecoration: BoxDecoration(color: Colors.transparent),
                          minScale: PhotoViewComputedScale.contained * 1,
                          maxScale: PhotoViewComputedScale.covered * 2.0,
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name:', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text(widget.pet.name, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Animal Type:', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text(widget.pet.animalType, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Breed:', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text(widget.pet.breed, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Age:', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text('${widget.pet.age} years old', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price(in USD):', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text('\$${widget.pet.price}', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 30.0),
                Material(
                  color: Color(0XFF697489),
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 150.0,
                    height: 60.0,
                    child: _isAdopted ? const Text('Adopted',  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white)) : const Text('Adopt Me',  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white)),
                    onPressed: _isAdopted ? null : () async {
                      setState(() {
                        _isAdopted = true;
                        _confettiController.play();
                      });

                      // Dispatch AdoptPet event with the correct index
                      // only if the index is valid
                      if (context.read<PetBloc>().state is PetsLoaded) {
                        final currentState = context.read<PetBloc>().state as PetsLoaded;
                        if (currentState.pets.any((element) => element == widget.pet)) {
                          final index = currentState.pets.indexOf(widget.pet);
                          context.read<PetBloc>().add(AdoptPet(index));
                        } else {
                          // Handle the case where the pet is not found in the current state
                          // (e.g., show an error message)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pet not found.'),
                            ),
                          );
                        }
                      }

                      // Simulate a short delay for demonstration
                      await Future.delayed(const Duration(seconds: 1));

                      commonAlertBox(context, 'Adoption Successful!', 'You have adopted ${widget.pet.name}!');
                    },
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              // blastDirection: pi / 2,
              shouldLoop: true,
              // createParticlePath: drawStar,
              emissionFrequency: 0, // how often it should emit
              numberOfParticles: 500, // number of particles to emit in one emission
              gravity: 0.1, // gravity - or fall speed
            ),
          )
        ],
      ),
    );
  }
}
