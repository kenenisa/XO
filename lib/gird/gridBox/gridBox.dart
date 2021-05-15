import 'package:flutter/material.dart';

class GridBox extends StatelessWidget {
  final List winningPattern;
  final getInput;
  final int index;

  GridBox(this.winningPattern, this.getInput, this.index);

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: winningPattern.firstWhere((el) => el == index.toString(),
                        orElse: () => null) ==
                    null
                ? Colors.white
                : Colors.white10,
            border: Border.all(width: 2.0, color: Colors.black38)),
        child: AnimatedOpacity(
            opacity: getInput(index) != '' ? 1.0 : 0.0,
            duration: Duration(milliseconds: 400),
            child: Container(
                child: getInput(index) == ''
                    ? Text('')
                    : Image.asset('assets/' + getInput(index) + '$index.png',
                        fit: BoxFit.cover))));
  }
}
