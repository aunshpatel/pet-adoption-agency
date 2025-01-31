import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import '../blocs/pet_block.dart';
import '../models/pet_model.dart';


class DetailsPage extends StatefulWidget {
  final Pet pet;
  const DetailsPage({Key? key, required this.pet}) : super(key: key);


  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool _isAdopting = false; // Track adoption state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
              Text('${widget.pet.name}', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text('${widget.pet.age} years old', style: const TextStyle(fontSize: 18.0)),
              Text('\$${widget.pet.price}', style: const TextStyle(fontSize: 18.0)),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isAdopting ? null : () async {
                  setState(() {
                    _isAdopting = true;
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

                  setState(() {
                    _isAdopting = false;
                  });
                },
                child: _isAdopting ? const CircularProgressIndicator() : const Text('Adopt Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
