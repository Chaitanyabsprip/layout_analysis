import 'dart:convert';
import 'dart:io';

const garbage = '   ';

typedef CountMap = Map<String, int>;

typedef NormalisedMap = Map<String, double>;

class Frequency {
  Frequency(this.corpus);

  final String corpus;

  final CountMap _ngramCount1 = {};
  final CountMap _ngramCount2 = {};
  final NormalisedMap _ngramNormalised1 = {};
  final NormalisedMap _ngramNormalised2 = {};

  CountMap ngramCount(int n) {
    final unigram = File(
      '/Users/chaitanyasharma/Projects/Languages/Dart/character_frequency_analysis/assets/unigram.json',
    );
    final bigram = File(
      '/Users/chaitanyasharma/Projects/Languages/Dart/character_frequency_analysis/assets/bigram.json',
    );
    if (n == 1 && _ngramCount1.isNotEmpty) {
      if (unigram.existsSync()) {
        return (jsonDecode(unigram.readAsStringSync()) as Map?)
                ?.cast<String, int>() ??
            <String, int>{};
      }
      return _ngramCount1;
    }
    if (n == 2 && _ngramCount2.isNotEmpty) {
      if (bigram.existsSync()) {
        return (jsonDecode(bigram.readAsStringSync()) as Map?)
                ?.cast<String, int>() ??
            <String, int>{};
      }
      return _ngramCount2;
    }

    if (corpus.isEmpty) return {};
    final ngrams = <String, int>{};
    final chars = corpus.trim().split('');
    for (var i = 0; i < chars.length - n + 1; i++) {
      final ngram = chars.sublist(i, i + n).join();
      ngrams[ngram] = (ngrams[ngram] ?? 0) + 1;
    }
    ngrams.removeWhere(
      (k, v) => k.contains(' ') || k.contains('\n') || k.contains('\t'),
    );
    if (n == 1) {
      _ngramCount1
        ..clear()
        ..addAll(ngrams);
      unigram.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(ngrams),
      );
    }
    if (n == 2) {
      _ngramCount2
        ..clear()
        ..addAll(ngrams);
      bigram.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(ngrams),
      );
    }
    return ngrams;
  }

  NormalisedMap ngramNormalised(int n) {
    if (corpus.isEmpty) return {};
    final unigram = File(
      '/Users/chaitanyasharma/Projects/Languages/Dart/character_frequency_analysis/assets/unigram_normalised.json',
    );
    final bigram = File(
      '/Users/chaitanyasharma/Projects/Languages/Dart/character_frequency_analysis/assets/bigram_normalised.json',
    );

    if (n == 1) {
      if (_ngramNormalised1.isNotEmpty) return _ngramNormalised1;
      if (unigram.existsSync()) {
        return (jsonDecode(unigram.readAsStringSync()) as Map?)
                ?.cast<String, double>() ??
            <String, double>{};
      }
    }
    if (n == 2) {
      if (_ngramNormalised2.isNotEmpty) return _ngramNormalised2;
      if (bigram.existsSync()) {
        return (jsonDecode(bigram.readAsStringSync()) as Map?)
                ?.cast<String, double>() ??
            <String, double>{};
      }
    }
    final ngrams = ngramCount(n);
    if (ngrams.isEmpty) return {};
    final total = ngrams.values.reduce((a, b) => a + b);
    final map = ngrams.map((key, value) => MapEntry(key, value / total));
    final convert = const JsonEncoder.withIndent('  ').convert(map);
    if (n == 1) {
      _ngramCount1
        ..clear()
        ..addAll(ngrams);
      unigram.writeAsStringSync(convert);
    }
    if (n == 2) {
      _ngramCount2
        ..clear()
        ..addAll(ngrams);
      bigram.writeAsStringSync(convert);
    }
    return map;
  }
}
