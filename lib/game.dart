import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  int currentSelection = -1;

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
  }

  Future<void> _initializePuzzle() async {
    PuzzleOptions puzzleOptions = PuzzleOptions(patternName: "winter");
    puzzle = Puzzle(puzzleOptions);
    await puzzle.generate();
    setState(() {});
  }

  void updateSelection(int newSelection) {
    setState(() {
      currentSelection = newSelection;
    });
  }

  void _numberInput(int number) {
    int block = currentSelection ~/ 9;
    int y = currentSelection % 9;
    int row = (block ~/ 3) * 3 + (y ~/ 3);
    int col = (block % 3) * 3 + (y % 3);
    if (puzzle.solvedBoard()?.matrix()?[row][col].getValue() == number) {
      setState(() {
        puzzle
            .board()!
            .cellAt(Position(row: row, column: col))
            .setValue(number);
      });
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oops!',
          message: 'Wrong guess, try again!',
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
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
                          child: MiniGrid(
                            puzzle: puzzle,
                            block: x,
                            selection: currentSelection,
                            onSelect: updateSelection,
                          ));
                    }),
                  )),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                        padding: const EdgeInsets.all(4),
                        child: ElevatedButton(
                            onPressed: () => _numberInput(index + 1),
                            child: Text("${index + 1}")));
                  })),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Padding(
                        padding: const EdgeInsets.all(4),
                        child: ElevatedButton(
                            onPressed: () => _numberInput(index + 6),
                            child: Text("${index + 6}")));
                  })),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => context.go('/end'),
                  child: const Text("Resolve"))
            ],
          ),
        ));
  }
}
