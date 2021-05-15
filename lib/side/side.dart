import 'package:flutter/material.dart';

class Side extends StatelessWidget {
  final String text;
  final String inside;
  final Color color;
  final func;

  Side(this.text, this.inside,this.color, this.func);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: func,
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          width: 150.0,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
              child:
                  Text(inside, style: Theme.of(context).textTheme.headline6)),
        ),
      ),
      Text(text, style: Theme.of(context).textTheme.headline4)
    ]);
  }
}
