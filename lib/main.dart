import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_adoption_center/screens/home_page.dart';

import 'blocs/pet_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PetBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home_page',
      routes: {
        '/home_page':(context) => const HomePage(),
        // '/history_page':(context) => const HistoryPage(),
      },
      // home: const HomePage(),
    );
  }
}