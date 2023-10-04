import 'dart:convert';

import 'config.dart';
import 'frequency.dart';
import 'layout.dart';

class Analysis {
  Analysis(this.config, this.frequency)
      : _layout = Layout(config.keymap, config.fingerMap);

  final Config config;
  final Frequency frequency;
  final Layout _layout;

  double get effortRating {
    final ngramNormalised = _ngramNormalised1;
    final effortMatrix = config.effortMatrix;
    var score = 0.0;
    for (var i = 0; i < _keymap.length; i++) {
      for (var j = 0; j < _keymap.first.length; j++) {
        score += effortMatrix[i][j] / 3 * (ngramNormalised[_keymap[i][j]] ?? 1);
      }
    }
    return score;
  }

  Map<String, double> get topSfb {
    final ngramNormalised = _ngramNormalised2;
    final sfbs = _layout.sfb.map((e) => MapEntry(e, ngramNormalised[e] ?? 0));
    final top = sfbs.toList()
      ..removeWhere((e) => e.value == 0)
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(top.take(10));
  }

  Map<int, double> get fingerEffort {
    final effortMap = <int, double>{};
    for (var i = 0; i < _fingerMap.length; i++) {
      for (var j = 0; j < _fingerMap.first.length; j++) {
        final fingerId = _fingerMap[i][j];
        final key = _keymap[i][j];
        final effortValue =
            config.effortMatrix[i][j] / 3 * (_ngramNormalised1[key] ?? 0);
        effortMap[fingerId] = (effortMap[fingerId] ?? 0) + effortValue;
      }
    }
    return effortMap;
  }

  double get inrollRating {
    if (_keymap.first.length < 2) return 0;
    final ngramNormalised = _ngramNormalised2;
    return _layout.inrolls.fold(
      0,
      (rating, bigram) => (ngramNormalised[bigram] ?? 0) + rating,
    );
  }

  double get outrollRating {
    if (_keymap.first.length < 2) return 0;
    final ngramNormalised = _ngramNormalised2;
    return _layout.outrolls.fold(
      0,
      (rating, bigram) => (ngramNormalised[bigram] ?? 0) + rating,
    );
  }

  double get characterRepeatEffort {
    var effort = 0.0;
    for (var i = 0; i < _keymap.length; i++) {
      for (var j = 0; j < _keymap.first.length; j++) {
        effort += (_ngramNormalised2[_keymap[i][j] * 2] ?? 0) *
            config.effortMatrix[i][j];
      }
    }
    return effort;
  }

  double get sfbRating {
    if (_keymap.length < 2) return 0;
    final ngramNormalised = _ngramNormalised2;
    return _layout.sfb.fold(
      0,
      (rating, sfb) => (ngramNormalised[sfb] ?? 0) + rating,
    );
  }

  double t(double number) {
    return (number * 1000).toInt() / 1000;
  }

  void prettyPrint() {
    final keymap = config.keymap;
    print('');
    print(keymap.map((row) => row.join('  ')).join('\n'));
    print('sfb: ${t(sfbRating * 100)}');
    final topSfb = this.topSfb..updateAll((_, v) => t(v * 100));
    print('top sfb: ${const JsonEncoder.withIndent('  ').convert(topSfb)}');
    print('inroll: ${t(inrollRating * 100)}');
    print('outroll: ${t(outrollRating * 100)}');
    print('effortRating: ${t(effortRating * 100)}');
    final fingerEffort = this.fingerEffort..updateAll((_, v) => t(v * 100));
    final convert = const JsonEncoder.withIndent('  ')
        .convert(fingerEffort.map((k, v) => MapEntry('$k', v)));
    print('fingerEffort: $convert');
    print('characterRepeatEffort: ${t(characterRepeatEffort * 100)}');
  }

  Matrix<int> get _fingerMap => config.fingerMap;

  Matrix<String> get _keymap => _layout.keymap;

  NormalisedMap get _ngramNormalised1 => frequency.ngramNormalised(1);

  NormalisedMap get _ngramNormalised2 => frequency.ngramNormalised(2);
}
