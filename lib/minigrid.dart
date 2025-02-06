import 'package:flutter/material.dart';

class MiniGrid extends StatelessWidget {
  const MiniGrid({super.key});

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
            child: const Center(child: Text("T")));
      }),
    );
  }
}
