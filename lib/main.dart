
import 'package:flutter/material.dart';
import 'package:pro/gird/grid.dart';
import 'package:pro/side/side.dart';
import 'package:pro/util/func.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red,
      ),
      home: MyHomePage(title: 'Tic tac who'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> inputs = [];
  List<List<String>> win = [
    ['0', '1', '2'],
    ['3', '4', '5'],
    ['6', '7', '8'],
    ['0', '3', '6'],
    ['1', '4', '7'],
    ['2', '5', '8'],
    ['0', '4', '8'],
    ['2', '4', '6'],
  ];
  String whoWon = '';
  String ability = 'smart';
  List<String> winningPattern = [];
  int _youScore = 0;
  int _cpuScore = 0;
  bool yourTurn = true;
  //

  bool _lookForWinner(String who) {
    bool result = false;
    win.forEach((el) {
      bool winnerExists = true;
      el.forEach((il) {
        final condition = inputs.firstWhere(
            (element) => element['index'] == il && element['indicator'] == who,
            orElse: () => null);
        if (condition == null) {
          winnerExists = false;
        }
      });
      if (winnerExists) {
        setState(() {
          winningPattern = el;
        });
        result = true;
      }
    });
    if (result == false && inputs.length > 8) {
      setState(() {
        whoWon = "It's a tie!";
      });
    }
    return result;
  }

  Future _schaduleCpuMove() {
    return new Future.delayed(Duration(seconds: 1), () {
      setState(() {
        inputs.add(new Func(inputs).makeCpuMove(ability));
        if (_lookForWinner('o')) {
          _cpuScore++;
          whoWon = (ability == 'smart' ? 'Cheer up!' : 'Loser!') +
              ' you lost to a $ability cpu';
        }
      });
    });
  }

  void _addInput(String input, String indicator) {
    if (whoWon == '') {
      if (inputs.length > 0 ? inputs.last['indicator'] != 'x' : true) {
        setState(() {
          Map<String, String> item = new Map();

          item['index'] = input;
          item['indicator'] = indicator;
          if (new Func(inputs).checkExisting(input) == false) {
            inputs.add(item);
            if (!_lookForWinner('x')) {
              _schaduleCpuMove();
            }
          }
          if (_lookForWinner('x')) {
            whoWon = 'You Won! bravo';
            _youScore++;
          }
        });
      }
    }
  }

  void _reset() {
    setState(() {
      inputs = [];
      winningPattern = [];
      whoWon = '';
      yourTurn = !yourTurn;
      if (!yourTurn) {
        inputs.add(new Func(inputs).makeCpuMove(ability));
      }
    });
  }

  void _toggleAbility() {
    setState(() {
      if (ability == 'smart') {
        ability = 'dumb';
      } else {
        ability = 'smart';
      }
    });
  }

  dynamic _checkExisting(input) => new Func(inputs).checkExisting(input);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Side(_youScore.toString(), 'You: x', Colors.red[400], () => {}),
                Side(_cpuScore.toString(), 'Cpu: $ability', Colors.blue[400],
                    _toggleAbility),
              ],
            ),
          ),
          Center(
            child: Text(whoWon, style: Theme.of(context).textTheme.headline5),
          ),
          Grid(winningPattern, _addInput, _checkExisting),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reset,
        tooltip: 'reset',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
