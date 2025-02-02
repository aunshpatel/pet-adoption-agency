import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_adoption_center/screens/history_page.dart';
import 'package:pet_adoption_center/screens/home_page.dart';
import 'package:pet_adoption_center/widgets/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'blocs/pet_bloc.dart';
import 'blocs/theme_bloc.dart';
import 'blocs/theme_event.dart';
import 'blocs/theme_state.dart';
import 'models/pet_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  final initialTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PetBloc()),
        BlocProvider(create: (context) => ThemeBloc(initialTheme)),
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
          theme: state.themeData,
          initialRoute: '/home_page',
          routes: {
            '/home_page': (context) => const HomePage(),
            '/history_page': (context) => const HistoryPage(),
          },
        );
      },
    );
  }
}