import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theme_bloc.dart';
import '../blocs/theme_event.dart';
import 'consts.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    // Get the current theme data to adapt the drawer color and text accordingly
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white, // Adjust background color
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            // Home Screen
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[850] : null, // Adjust header color based on theme
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "The Pet Adoption Agency",
                    style: isDarkMode
                        ? theme.textTheme.headlineSmall?.copyWith(color: Colors.white) // Dark mode headlineSmall
                        : theme.textTheme.headlineSmall?.copyWith(color: Colors.black), // Light mode headlineSmall
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Find and adopt your pet here!",
                    style: isDarkMode
                        ? theme.textTheme.bodyLarge?.copyWith(color: Colors.white) // Dark mode bodyLarge
                        : theme.textTheme.bodyLarge?.copyWith(color: Colors.black), // Light mode bodyLarge
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: isDarkMode ? Colors.white : theme.iconTheme.color, // Icon color based on theme
                size: 30,
              ),
              title: Wrap(
                children: [
                  Text(
                    'Home ',
                    style: isDarkMode
                        ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) // Dark mode titleLarge
                        : theme.textTheme.titleLarge?.copyWith(color: Colors.black), // Light mode titleLarge
                  ),
                  Text(
                    'Page',
                    style: isDarkMode
                        ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) // Dark mode titleLarge
                        : theme.textTheme.titleLarge?.copyWith(color: Colors.black), // Light mode titleLarge
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/home_page');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.history,
                color: isDarkMode ? Colors.white : theme.iconTheme.color, // Icon color based on theme
                size: 30,
              ),
              title: Wrap(
                children: [
                  Text(
                    'History ',
                    style: isDarkMode
                        ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) // Dark mode titleLarge
                        : theme.textTheme.titleLarge?.copyWith(color: Colors.black), // Light mode titleLarge
                  ),
                  Text(
                    'Page',
                    style: isDarkMode
                        ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) // Dark mode titleLarge
                        : theme.textTheme.titleLarge?.copyWith(color: Colors.black), // Light mode titleLarge
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/history_page');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.brightness_6, // Icon for toggling theme
                color: isDarkMode ? Colors.white : theme.iconTheme.color, // Icon color based on theme
                size: 30,
              ),
              title: Wrap(
                children: [
                  Text(
                    'Toggle ',
                    style: isDarkMode
                        ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) // Dark mode titleLarge
                        : theme.textTheme.titleLarge?.copyWith(color: Colors.black), // Light mode titleLarge
                  ),
                  Text(
                    'Theme',
                    style: isDarkMode
                        ? theme.textTheme.titleLarge?.copyWith(color: Colors.white) // Dark mode titleLarge
                        : theme.textTheme.titleLarge?.copyWith(color: Colors.black), // Light mode titleLarge
                  ),
                ],
              ),
              onTap: () {
                context.read<ThemeBloc>().add(ToggleTheme()); // Trigger theme change
              },
            ),
          ],
        ),
      ),
    );
  }
}
