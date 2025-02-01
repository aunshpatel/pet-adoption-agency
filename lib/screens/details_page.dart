import 'dart:math';

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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Future<void> commonAlertBox(BuildContext context, String title, String message)  {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog.adaptive(
            title: Text(title, style:  isDarkMode ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) : theme.textTheme.titleLarge?.copyWith(color: Colors.black)),
            content: Text(message, style:  isDarkMode  ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) : theme.textTheme.titleLarge?.copyWith(color: Colors.black)),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('OK', style: isDarkMode ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) : theme.textTheme.titleLarge?.copyWith(color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: Text(
          'Pet Details',
          style: isDarkMode ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) : theme.textTheme.titleLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  color: isDarkMode ? Colors.grey[850] : Colors.white,  // Adjust card color based on theme
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildDetailRow('Name:', widget.pet.name),
                        _buildDetailRow('Animal Type:', widget.pet.animalType),
                        _buildDetailRow('Breed:', widget.pet.breed),
                        _buildDetailRow('Age:', '${widget.pet.age} years old'),
                        _buildDetailRow('Price:', '\$ ${widget.pet.price}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// **Adoption Button**
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.pet.isAdopted
                        ? (isDarkMode ? Colors.grey[500] : Colors.grey[700]) // Adjust button color for adopted pets
                        : (isDarkMode ? Colors.grey[500] : Colors.grey[700]), // Active button color matches the theme
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
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 500,
                gravity: 0.2,
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isDarkMode ? theme.textTheme.bodyLarge?.copyWith(color: Colors.white) : theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
          ),
          Text(
            value,
            style: isDarkMode ? theme.textTheme.bodyLarge?.copyWith(color: Colors.white) : theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
