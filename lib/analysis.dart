import 'config.dart';
import 'frequency.dart';
import 'layout.dart';

class Analysis {
  Analysis(this.config, this.frequency) : _layout = Layout(config.keymap);

  final Config config;
  final Frequency frequency;
  final Layout _layout;

  Matrix<String> get _keymap => _layout.keymap;

  double get effortRating {
    final ngramNormalised = frequency.ngramNormalised(1);
    final effortMatrix = config.effortMatrix;
    var score = 0.0;
    for (var i = 0; i < _keymap.length; i++) {
      for (var j = 0; j < _keymap.first.length; j++) {
        score += effortMatrix[i][j] * (ngramNormalised[_keymap[i][j]] ?? 1);
      }
    }

    return score;
  }

  double get outrollRating {
    if (_keymap.first.length < 2) return 0;
    final ngramNormalised = _ngramNormalised2;
    return _layout.outrolls.fold(
      0,
      (rating, bigram) => (ngramNormalised[bigram] ?? 0) + rating,
    );
  }

  double get inrollRating {
    if (_keymap.first.length < 2) return 0;
    final ngramNormalised = _ngramNormalised2;
    return _layout.inrolls.fold(
      0,
      (rating, bigram) => (ngramNormalised[bigram] ?? 0) + rating,
    );
  }

  NormalisedMap get _ngramNormalised2 => frequency.ngramNormalised(2);

  double get sfbRating {
    if (_keymap.length < 2) return 0;
    final ngramNormalised = _ngramNormalised2;
    return _layout.sfb.fold(
      0,
      (rating, sfb) => (ngramNormalised[sfb] ?? 0) + rating,
    );
  }
}
