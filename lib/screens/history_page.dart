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
        title: const Text('History Page',),
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
                      return const Center(child: Text('No Pet Adopted', style: kSideMenuLightTextStyle));
                    } else {
                      return ListView.builder(
                        itemCount: adoptedPets.length,
                        itemBuilder: (context, index) {
                          final pet = adoptedPets[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAlias,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 0 , 15, 0),
                                child: GestureDetector(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                BorderRadius.circular(20),
                                              ),
                                              height: 230,
                                            ),
                                            SizedBox(
                                              height: 230,
                                              child: Center(
                                                child: Hero(
                                                    tag: 'petImage - ${pet.name}',
                                                    child: ClipRRect(
                                                      child: Image.asset(pet.image,fit: BoxFit.cover,),
                                                    )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 25),
                                          child: SizedBox(
                                            height: 150,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(pet.name, style: kSideMenuDarkTextStyle),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(pet.breed, style: kLightSemiBoldTextStyle),
                                                  Text('${pet.age} years old', style:kLightSemiBoldTextStyle),
                                                  if(pet.isAdopted)...[
                                                    Text("Adopted", style:kDarkSemiBoldTextStyle),
                                                  ]
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // if(pet.isAdopted)...[
                                      //   Text("Adopted", style:kLightSemiBoldTextStyle),
                                      // ]
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      createCustomRoute(DetailsPage(pet: pet)),
                                    );
                                  },
                                )
                            ),
                          );
                        },
                      );
                    }
                  } else if (state is PetError) {
                    return Center(child: Text('Error: ${state.message}', style: kSideMenuLightTextStyle));
                  } else {
                    return const Center(child: Text('Unexpected State', style: kSideMenuLightTextStyle));
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