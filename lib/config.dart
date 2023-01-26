import 'layout.dart';

bool _hasConsistenColumns<T>(Matrix<T> matrix) =>
    matrix.every((row) => row.length == matrix.first.length);

class Config {
  Config(this.keymap, this.effortMatrix, this.fingerMap)
      : assert(
          keymap.isNotEmpty && effortMatrix.isNotEmpty && fingerMap.isNotEmpty,
          'layout, effort matrix and finger map should have at least one row',
        ),
        assert(
          keymap.first.isNotEmpty &&
              effortMatrix.first.isNotEmpty &&
              fingerMap.first.isNotEmpty,
          'layout, effort matrix and finger map must have at least one column',
        ),
        assert(
          keymap.length == effortMatrix.length &&
              keymap.length == fingerMap.length,
          'layout, effort matrix and finger map must have same number of rows',
        ),
        assert(
          keymap.first.length == effortMatrix.first.length &&
              keymap.first.length == fingerMap.first.length,
          'layout, effort matrix and finger map '
          'must have same number of columns',
        ),
        assert(
          _hasConsistenColumns(effortMatrix) &&
              _hasConsistenColumns(fingerMap) &&
              _hasConsistenColumns(keymap),
          'all rows must have same length',
        ),
        assert(
          effortMatrix.every((row) => row.every((e) => e >= 1)),
          'should be greater than 1',
        ),
        assert(
          fingerMap.every((row) => row.every((e) => e > -1)),
          'finger map value should be a natural number',
        );

  Matrix<double> effortMatrix;
  Matrix<String> keymap;
  Matrix<int> fingerMap;
}
