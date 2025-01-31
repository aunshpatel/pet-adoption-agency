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
                hintText: 'Search by name',
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<PetBloc, PetState>(
                builder: (context, state) {
                  if (state is PetInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PetsLoaded) {
                    return ListView.builder(
                      itemCount: state.pets.length,
                      itemBuilder: (context, index) {
                        final pet = state.pets[index];
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ListTile(
                            title: Text(pet.name, style:TextStyle(fontWeight: FontWeight.bold,),),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(pet.breed, style:TextStyle(fontWeight: FontWeight.w500,)),
                                Text('${pet.age} years old', style:TextStyle(fontWeight: FontWeight.w500,)),
                              ],
                            ),
                            leading: Hero(
                                tag: 'petImage - ${pet.name}',
                                child: ClipRRect(
                                  child: Image.asset(pet.image,width: 80,height: 90,fit: BoxFit.cover,),
                                )
                            ),
                            trailing: pet.isAdopted ? const Text('Adopted', style:TextStyle(fontWeight: FontWeight.w500,)) : null,
                            onTap: () {
                              Navigator.push(
                                context,
                                createCustomRoute(DetailsPage(pet: pet)),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is PetsUpdated) {
                    return ListView.builder(
                      itemCount: state.pets.length,
                      itemBuilder: (context, index) {
                        final pet = state.pets[index];
                        return ListTile(
                          title: Text(pet.name, style:TextStyle(fontWeight: FontWeight.bold,),),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(pet.breed, style:TextStyle(fontWeight: FontWeight.w500,)),
                              Text('${pet.age} years old', style:TextStyle(fontWeight: FontWeight.w500,)),
                            ],
                          ),
                          leading: Hero(
                            tag: 'petImage - ${pet.name}',
                            child: ClipRRect(
                              child: Image.asset(pet.image,width: 80,height: 90,fit: BoxFit.cover,),
                            )
                          ),
                          trailing: pet.isAdopted
                              ? const Text('Adopted', style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                              : null,
                          onTap: () {
                            Navigator.push(
                              context,
                              createCustomRoute(DetailsPage(pet: pet)),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Something went wrong', style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18),));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Route createCustomRoute(Widget page) {
  //   return PageRouteBuilder(
  //     transitionDuration: Duration(milliseconds: 600),
  //     pageBuilder: (context, animation, secondaryAnimation) => page,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
  //       var scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
  //         CurvedAnimation(parent: animation, curve: Curves.easeOut),
  //       );
  //
  //       return FadeTransition(
  //         opacity: fadeAnimation,
  //         child: ScaleTransition(
  //           scale: scaleAnimation,
  //           child: child,
  //         ),
  //       );
  //     },
  //   );
  // }
}