import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/pet_bloc.dart';
import '../widgets/consts.dart';
import '../widgets/side_drawer.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

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
        title: const Text('Home Page'),
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<PetBloc>().add(SearchPets(query: value));
              },
              decoration: const InputDecoration(
                hintText: 'Search the name',
                prefixIcon: Icon(Icons.search_rounded),
                border: OutlineInputBorder(),
                focusColor: kDarkTitleColor,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<PetBloc, PetState>(
                builder: (context, state) {
                  if (state is PetInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PetsLoaded) {
                    return SizedBox(
                      child: SizedBox(
                        height: 570,
                        child: ListView.builder(
                          itemCount: state.pets.length,
                          itemBuilder: (context, index) {
                            final pet = state.pets[index];
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
                        ),
                      ),
                    );
                  } else if (state is PetsUpdated) {
                    return ListView.builder(
                      itemCount: state.pets.length,
                      itemBuilder: (context, index) {
                        final pet = state.pets[index];
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
                  } else {
                    return const Center(child: Text('Something went wrong', style:kBoldFont18));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}