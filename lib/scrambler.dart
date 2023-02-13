// Global headers
import 'dart:math';
import 'package:flutter/material.dart';

// Local header
import 'classes/moves_2x2.dart';
import 'classes/moves_3x3.dart';
import 'classes/moves_4x4.dart';
import 'classes/moves_5x5.dart';

class Scrambler extends StatefulWidget {
  const Scrambler({super.key});

  @override
  State<Scrambler> createState() => _ScramblerState();
}

class _ScramblerState extends State<Scrambler> {
  // Global vars
  late String _scramble = '';

  // cubeType vars
  late String cubeType = '3x3'; // default to 3x3
  late int scrambleLength;
  late List<String> movesToUse;

  final Map<String, int> scrambleLengthMap = {
    // Normal cubes
    '2x2': Moves2x2.length,
    '3x3': Moves3x3.length,
    '4x4': Moves4x4.length,
    '5x5': Moves5x5.length,
  };

  final Map<String, List<String>> movesToUseMap = {
    // Normal cubes
    '2x2': Moves2x2.moves,
    '3x3': Moves3x3.moves,
    '4x4': Moves4x4.moves,
    '5x5': Moves5x5.moves,
  };

  // Generate Scramble script
  void _generateScramble() {
    // ToDo: Improve it
    var random = Random();
    setState(() {
      _scramble = '';
      String lastMove = '';
      scrambleLength =
          (scrambleLengthMap[cubeType] ?? scrambleLengthMap['3x3'])!;
      movesToUse = (movesToUseMap[cubeType] ?? movesToUseMap['3x3'])!;
      for (int i = 0; i < scrambleLength; i++) {
        String move = movesToUse[random.nextInt(movesToUse.length)];
        while (i > 0 && move[0] == lastMove[0]) {
          move = movesToUse[random.nextInt(movesToUse.length)];
        }
        lastMove = move;
        _scramble += '$move ';
      }
    });
  }

  // UI/UX
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text('FluScrambler',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer)),
      ),
      // ToDo: Improve UI/UX
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _scramble.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      _scramble,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Select a cube and press 'Generate scramble'",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    )),
            // ToDo: Move it in a different screen with all the cubes there
            DropdownButton<String>(
              menuMaxHeight: 200,
              value: cubeType,
              onChanged: (value) {
                setState(() {
                  cubeType = value!;
                });
              },
              items: [
                for (var cube in ['2x2', '3x3', '4x4', '5x5'])
                  DropdownMenuItem<String>(
                    value: cube,
                    child: Text(cube),
                  ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _generateScramble,
        label: const Text('Generate Scramble'),
        icon: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(), // Dummy for now
    );
  }
}
