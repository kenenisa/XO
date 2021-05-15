import 'dart:math';

class Func {
  final List inputs;
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
  Func(this.inputs);

  List<String> _flattenToIndexes(who) {
    List<String> indexes = [];
    inputs.forEach((element) {
      if (who != null ? element['indicator'] == who : true) {
        indexes.add(element['index']);
      }
    });
    return indexes;
  }

  String _nextItem(String first, String second) {
    final indexes = _flattenToIndexes(first);
    String found;
    win.forEach((el) {
      String nextItem;
      List<String> ext = [];
      el.forEach((il) {
        if (indexes.contains(il)) {
          ext.add(il);
        } else {
          nextItem = il;
        }
      });
      if (ext.length == 2 && !_flattenToIndexes(second).contains(nextItem)) {
        found = nextItem;
      }
    });
    if (found == null) {
      if (second == null) {
        return Random().nextInt(8).toString();
      }
      return _nextItem('x', null);
    }
    return found;
  }
dynamic checkExisting(String index) {
    dynamic exists = false;
    inputs.forEach((element) {
      if (element['index'] == index.toString()) {
        exists = element['indicator'];
      }
    });
    return exists;
  }
  String _findPosition(ability) {
    //
    String rand = ability == 'smart'
        ? _nextItem('o', 'x')
        : Random().nextInt(8).toString();
    if (checkExisting(rand) == false) {
      return rand;
    } else {
      if (inputs.length < 8) {
        return _findPosition(ability);
      } else {
        return '';
      }
    }
  }
  
  Map<String, String> makeCpuMove(ability) {
    Map<String, String> item = new Map();
    final input = _findPosition(ability);
    item['index'] = input;
    item['indicator'] = 'o';
    return item;
  }

  
}
