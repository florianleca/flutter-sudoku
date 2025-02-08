import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

class MiniGrid extends StatelessWidget {
  const MiniGrid(
      {super.key,
      required this.puzzle,
      required this.block,
      required this.selection,
      required this.onSelect});

  final Puzzle puzzle;
  final int block;
  final int selection;
  final ValueChanged<int> onSelect;

  String _getValue(int y) {
    int? value = puzzle.board()?.matrix()?[block][y].getValue();
    if (value == null || value == 0) {
      value = puzzle.solvedBoard()?.matrix()?[block][y].getValue();
    }
    return value.toString();
  }

  bool _isHiddenValue(int y) {
    return puzzle.board()?.matrix()?[block][y].getValue() == 0;
  }

  int _getCellNumber(int x) {
    return 9 * block + x;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 2;
    var width = MediaQuery.of(context).size.width;
    var maxSize = height > width ? width : height;
    var boxSize = (maxSize / 3).ceil().toDouble();
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(9, (x) {
        return Material(
            child: InkWell(
                onTap: _isHiddenValue(x)
                    ? () => onSelect(_getCellNumber(x))
                    : null,
                child: Container(
                  width: boxSize,
                  height: boxSize,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.3),
                      color: selection == _getCellNumber(x)
                          ? Colors.blueAccent.shade100.withAlpha(100)
                          : Colors.transparent),
                  child: Center(
                    child: Text(
                      _getValue(x),
                      style: _isHiddenValue(x)
                          ? const TextStyle(color: Colors.black12)
                          : null,
                    ),
                  ),
                )));
      }),
    );
  }
}
