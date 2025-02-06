import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

class MiniGrid extends StatelessWidget {
  final Puzzle puzzle;
  final int block;

  const MiniGrid({super.key, required this.puzzle, required this.block});

  String getValue(int y) {
    int? value = puzzle.board()?.matrix()?[block][y].getValue();
    if (value == null || value == 0) return "";
    return value.toString();
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
        return Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Center(child: Text(getValue(x))));
      }),
    );
  }
}
