import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_adoption_center/screens/history_page.dart';
import 'package:pet_adoption_center/screens/home_page.dart';

import 'blocs/pet_bloc.dart';
import 'blocs/theme_bloc.dart';
import 'blocs/theme_state.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PetBloc()),  // Your PetBloc
        BlocProvider(create: (context) => ThemeBloc()),  // Your ThemeBloc
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Pet Adoption',
          theme: state.themeData,  // Apply dynamic theme from ThemeBloc
          initialRoute: '/home_page', // Default starting route
          routes: {
            '/home_page': (context) => const HomePage(),  // Your HomePage route
            '/history_page': (context) => const HistoryPage(),  // Your HistoryPage route
          },
        );
      },
    );
  }
}