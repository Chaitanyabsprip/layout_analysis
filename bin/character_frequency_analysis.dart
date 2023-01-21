import 'package:character_frequency_analysis/frequency.dart';

void main(List<String> arguments) {
  final timer = Stopwatch();
  const corpus = '''
// Map<String, int> ngramCount(int n) {
//   if (corpus.isEmpty) return {};
//   final ngrams = <String, int>{};
//   final inputList = corpus.trim().split('');
//   for (var i = 0; i < inputList.length - n + 1; i++) {
//     final ngram = inputList.sublist(i, i + n).join();
//     ngrams[ngram] = (ngrams[ngram] ?? 0) + 1;
//   }
//   return ngrams..removeWhere((k, v) => k.contains(' '));
// }
//
// Map<String, double> ngramNormalised(int n) {
//   if (corpus.isEmpty) return {};
//   final ngrams = ngramCount(n);
//   if (ngrams.isEmpty) return {};
//   final total = ngrams.values.reduce((a, b) => a + b);
//   return ngrams.map((key, value) => MapEntry(key, value / total));
// }

const garbage = '   ';
typedef CountMap = Map<String, int>;

typedef PercentMap = Map<String, double>;

class Analyser {
  Analyser(this.corpus);

  final String corpus;

  Map<String, int> ngramCount(int n) {
    if (corpus.isEmpty) return {};
    final ngrams = <String, int>{};
    final chars = corpus.trim().split('');
    for (var i = 0; i < chars.length - n + 1; i++) {
      final ngram = chars.sublist(i, i + n).join();
      ngrams[ngram] = (ngrams[ngram] ?? 0) + 1;
    }
    return ngrams..removeWhere((k, v) => k.contains(' '));
  }

  Map<String, double> ngramNormalised(int n) {
    if (corpus.isEmpty) return {};
    final ngrams = ngramCount(n);
    if (ngrams.isEmpty) return {};
    final total = ngrams.values.reduce((a, b) => a + b);
    return ngrams.map((key, value) => MapEntry(key, value / total));
  }
}

import 'package:character_frequency_analysis/character_frequency_analysis.dart';
import 'package:test/test.dart';

// should be able to get unigram frequency in absolute number
// should be able to get unigram frequency in normalised form
// should be able to get bigram frequency in absolute number
// should be able to get bigram frequency in normalised form
// should be able to get finger wise sfb normalised form
// should be able to get total sfb normalised form
// should be able to get top ten sfb normalised form

void main() {
  group('get unigram frequency in absolute number', () {
    group('in absolute number', () {
      test('when input is empty, output should be {}', () {
        final analyser = Analyser('');
        expect(analyser.ngramCount(1), equals({}));
      });

      test('when input is "a", output should be {"a": 1}', () {
        final analyser = Analyser('a');
        expect(analyser.ngramCount(1), equals({'a': 1}));
      });

      test('when input is "aa", output should be {"a": 2}', () {
        final analyser = Analyser('aa');
        expect(analyser.ngramCount(1), equals({'a': 2}));
      });

      test('when input is "ba", output should be {"a": 1, "b": 1}', () {
        final analyser = Analyser('ba');
        expect(analyser.ngramCount(1), equals({'a': 1, 'b': 1}));
      });

      test('when input is "a b", output should be {"a": 1, "b": 1}', () {
        final analyser = Analyser('a b');
        expect(analyser.ngramCount(1), equals({'a': 1, 'b': 1}));
      });
    });

    group('in normalised form', () {
      test('when input is empty, output should be {}', () {
        final analyser = Analyser('');
        expect(analyser.ngramNormalised(1), equals({}));
      });

      test('when input is "a", output should be {"a": 1}', () {
        final analyser = Analyser('a');
        expect(analyser.ngramNormalised(1), equals({'a': 1}));
      });

      test('when input is "ab", output should be {"a": 0.5, "b": 0.5}', () {
        final analyser = Analyser('ab');
        expect(analyser.ngramNormalised(1), equals({'a': 0.5, 'b': 0.5}));
      });

      test('when input is "a ", output should be {"a": 1}', () {
        final analyser = Analyser('a ');
        expect(analyser.ngramNormalised(1), equals({'a': 1}));
      });

      test('when input is "aba", output should be {"a": 0.67, "b": 0.33}', () {
        final analyser = Analyser('aba');
        expect(analyser.ngramNormalised(1), equals({'a': 2 / 3, 'b': 1 / 3}));
      });
    });
  });

  group('get bigram frequency in absolute number', () {
    group('in absolute number', () {
      test('when input is "ab", output should be {"ab": 1}', () {
        final analyser = Analyser('ab');
        expect(analyser.ngramCount(2), equals({'ab': 1}));
      });

      test('when input is "ac", output should be {"ac": 1}', () {
        final analyser = Analyser('ac');
        expect(analyser.ngramCount(2), equals({'ac': 1}));
      });

      test('when input is "a c", output should be {}', () {
        final analyser = Analyser('a c');
        expect(analyser.ngramCount(2), equals({}));
      });

      test('when input is "abc", output should be {"ab":1,"bc":1}', () {
        final analyser = Analyser('abc');
        expect(analyser.ngramCount(2), equals({'ab': 1, 'bc': 1}));
      });

      test('when input is "abcabc", output should be {"ab":2,"bc":2, "ca":1}',
          () {
        final analyser = Analyser('abcabc');
        expect(analyser.ngramCount(2), equals({'ab': 2, 'bc': 2, 'ca': 1}));
      });

      test('when input is "  ", output should be {}', () {
        final analyser = Analyser('  ');
        expect(analyser.ngramNormalised(2), equals({}));
      });

      test('when input is "\t\t", output should be {}', () {
        final analyser = Analyser('\t\t');
        expect(analyser.ngramNormalised(2), equals({}));
      });
    });

    group('in normalised form', () {
      test('when input is empty, output should be {}', () {
        final analyser = Analyser('');
        expect(analyser.ngramNormalised(2), equals({}));
      });

      test('when input is "a", output should be {}', () {
        final analyser = Analyser('a');
        expect(analyser.ngramNormalised(2), equals({}));
      });

      test('when input is "ab", output should be {"ab": 1}', () {
        final analyser = Analyser('ab');
        expect(analyser.ngramNormalised(2), equals({'ab': 1}));
      });

      test('when input is "a ", output should be {}', () {
        final analyser = Analyser('a ');
        expect(analyser.ngramNormalised(2), equals({}));
      });

      test('when input is "a b", output should be {}', () {
        final analyser = Analyser('a b');
        expect(analyser.ngramNormalised(2), equals({}));
      });

      test('when input is "aba", output should be {"ab": 0.67, "ba": 0.33}',
          () {
        final analyser = Analyser('aba');
        expect(analyser.ngramNormalised(2), equals({'ab': 0.5, 'ba': 0.5}));
      });

      test('when input is "  ", output should be {}', () {
        final analyser = Analyser('  ');
        expect(analyser.ngramNormalised(2), equals({}));
      });

      test('when input is "\t\t", output should be {}', () {
        final analyser = Analyser('\t\t');
        expect(analyser.ngramNormalised(2), equals({}));
      });
    });
  });
}
''';

  final analyser = Frequency(corpus /*201 lines*/ * 100000);
  timer.start();
  print(analyser.ngramCount(1).containsKey('\n'));
  timer.stop();
  print(timer.elapsedMilliseconds);
}
