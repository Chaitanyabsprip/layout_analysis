typedef Matrix<T> = List<List<T>>;

class Layout {
  Layout(this.keymap)
      : assert(keymap.isNotEmpty, 'should have at least 1 row'),
        assert(keymap.first.isNotEmpty, 'should have atleast one char'),
        assert(
          keymap.every((row) => row.length == keymap.first.length),
          'each row should be of same length',
        ) {
    final flattened = keymap.expand((r) => r);
    assert(
      flattened.toSet().length == flattened.length,
      'all characters should be unique',
    );
  }
  final Matrix<String> keymap;

  List<String> get inrolls {
    final leftHandInrolls = left.fold<List<String>>([], (possibleInrolls, row) {
      for (var i = 0; i < row.length - 1; i++) {
        possibleInrolls.add(row.sublist(i, i + 2).join());
      }
      return possibleInrolls;
    });
    final rightHandInrolls =
        right.fold<List<String>>([], (possibleInrolls, row) {
      for (var i = 0; i < row.length - 1; i++) {
        possibleInrolls.add(row.sublist(i, i + 2).reversed.join());
      }
      return possibleInrolls;
    });
    return leftHandInrolls..addAll(rightHandInrolls);
  }

  Matrix<String> get left {
    return keymap.fold(
      <List<String>>[],
      (leftHand, row) =>
          leftHand..add(row.sublist(0, (row.length / 2).floor())),
    );
  }

  Matrix<String> get right {
    return keymap.fold(
      <List<String>>[],
      (rightHand, row) => rightHand..add(row.sublist((row.length / 2).floor())),
    );
  }

  List<String> get sfb {
    if (keymap.length == 1) return [''];
    final possibleSfbs = <String>[];
    for (var i = 0; i < keymap.first.length; i++) {
      for (var j = 0; j < keymap.length; j++) {
        for (var k = 0; k < keymap.length; k++) {
          possibleSfbs
            ..add(keymap[j][i] + keymap[k][i])
            ..add(keymap[k][i] + keymap[j][i]);
        }
      }
    }
    possibleSfbs
        .removeWhere((element) => element.split('').toSet().length == 1);
    return possibleSfbs.toSet().toList();
  }
}
