// Global headers
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

// Local headers
import 'scrambler.dart';

void main() => runApp(const MyApp());

Color brandColor = const Color(0xFF6750A4); // Main app theme

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? dark) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      // Android 12 chekcs
      if (lightDynamic != null && dark != null) {
        // Use Material You (Monet, Md3) color scheme
        lightColorScheme = lightDynamic.harmonized();
        darkColorScheme = dark.harmonized();
      } else {
        // Use the main color scheme theme
        lightColorScheme = ColorScheme.fromSeed(seedColor: brandColor);
        darkColorScheme = ColorScheme.fromSeed(
            seedColor: brandColor, brightness: Brightness.dark);
      }
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
    });
  }
}
