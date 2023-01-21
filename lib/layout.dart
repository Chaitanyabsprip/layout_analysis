typedef Matrix<T> = List<List<T>>;

class Layout {
  Layout(this.layout)
      : assert(layout.isNotEmpty, 'should have at least 1 row'),
        assert(layout.first.isNotEmpty, 'should have atleast one char'),
        assert(
          layout.every((row) => row.length == layout.first.length),
          'each row should be of same length',
        ) {
    final flattened = layout.expand((r) => r);
    assert(
      flattened.toSet().length == flattened.length,
      'all characters should be unique',
    );
  }

  final Matrix<String> layout;

  List<String> get sfb {
    if (layout.length == 1) return [''];
    final possibleSfbs = <String>[];
    for (var i = 0; i < layout.first.length; i++) {
      for (var j = 0; j < layout.length; j++) {
        for (var k = 0; k < layout.length; k++) {
          possibleSfbs
            ..add(layout[j][i] + layout[k][i])
            ..add(layout[k][i] + layout[j][i]);
        }
      }
    }
    return possibleSfbs.toSet().toList();
  }
}
