import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:sudoku_starter/minigrid.dart';

class Game extends StatefulWidget {
  const Game({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late Puzzle puzzle;

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
  }

  Future<void> _initializePuzzle() async {
    PuzzleOptions puzzleOptions = PuzzleOptions(patternName: "winter");
    puzzle = Puzzle(puzzleOptions);
    await puzzle.generate();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 2;
    var width = MediaQuery.of(context).size.width;
    var maxSize = height > width ? width : height;
    var boxSize = (maxSize / 3).ceil().toDouble();

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: boxSize * 3,
                  height: boxSize * 3,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(9, (x) {
                      return Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)),
                          child: MiniGrid(puzzle: puzzle, block: x));
                    }),
                  )),
            ],
          ),
        ));
  }
}
