import 'package:flutter/material.dart';
import 'package:pro/gird/gridBox/gridBox.dart';

class Grid extends StatelessWidget {
  final List winningPattern;
  final _addInput;
  final _checkExisting;

  Grid(this.winningPattern, this._addInput, this._checkExisting);
  
  String _getInput(int index) {
    final item = _checkExisting(index.toString());
    if (!(item == false)) {
      return item;
    }
    return '';
  }

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(9, (index) {
          return GestureDetector(
              onTap: () => _addInput(index.toString(), 'x'),
              child: GridBox(winningPattern, _getInput, index));
        }),
      ),
    );
  }
}
