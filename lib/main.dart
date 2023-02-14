// Global headers
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

// Local headers
import 'scrambler.dart';

void main() => runApp(const MyApp());

Color brandColor = const Color.fromRGBO(103, 80, 164, 1); // Main app theme

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (light, dark) {
        final lightColorScheme =
            light?.harmonized() ?? ColorScheme.fromSeed(seedColor: brandColor);
        final darkColorScheme = dark?.harmonized() ??
            ColorScheme.fromSeed(
                seedColor: brandColor, brightness: Brightness.dark);

        return MaterialApp(
          title: 'FluScrambler',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          debugShowCheckedModeBanner: false,
          home: const Scrambler(),
        );
      },
    );
  }
}
