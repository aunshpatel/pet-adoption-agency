import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pet_bloc.dart';
import '../widgets/consts.dart';
import '../widgets/side_drawer.dart';
import 'details_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<PetBloc>().add(LoadPets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: kDarkTitleColor,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: const Text('History Page'),
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<PetBloc, PetState>(
                builder: (context, state) {
                  if (state is PetInitial || state is PetsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PetsLoaded) {
                    final adoptedPets = state.pets.where((pet) => pet.isAdopted).toList();
                    if (adoptedPets.isEmpty) {
                      return const Center(child: Text('No Pet Adopted', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)));
                    } else {
                      return ListView.builder(
                        itemCount: adoptedPets.length,
                        itemBuilder: (context, index) {
                          final pet = adoptedPets[index];
                          return Card(
                            elevation: 6,
                            child:Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: ListTile(
                                title: Text(pet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(pet.breed, style: const TextStyle(fontWeight: FontWeight.w500)),
                                    Text('${pet.age} years old', style: const TextStyle(fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                leading: Hero(
                                  tag: 'petImage - ${pet.name}',
                                  child: ClipRRect(
                                    child: Image.asset(pet.image, width: 80, height: 90, fit: BoxFit.cover),
                                  ),
                                ),
                                trailing: const Text('Adopted', style: TextStyle(fontSize:16, fontWeight: FontWeight.w500)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    createCustomRoute(DetailsPage(pet: pet)),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else if (state is PetError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('Unexpected State'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}