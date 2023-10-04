import 'package:character_frequency_analysis/analysis.dart';
import 'package:character_frequency_analysis/config.dart';
import 'package:character_frequency_analysis/frequency.dart';
import 'package:character_frequency_analysis/layout.dart';
import 'package:test/test.dart';

void main() {
  // for analysis, I need the frequency of ngrams, for that I need a corpus
  // for analysis, I also need the layout.

  Config getConfigFrom(Matrix<String> layout) {
    return Config(
      layout,
      layout.map((e) => e.map((f) => 1.0).toList()).toList(),
      layout.map((e) => e.map((f) => 0).toList()).toList(),
    );
  }

  group('get single finger bigram(SFB)', () {
    group('when corpus is "abc", ', () {
      final frequency = Frequency('abc');

      test('layout is [[a]], output should be 0', () {
        final analysis = Analysis(
          getConfigFrom([
            ['a']
          ]),
          frequency,
        );
        expect(analysis.sfbRating, 0);
      });

      test('layout is [[a], [b]], output should be 0.5', () {
        final analysis = Analysis(
          getConfigFrom([
            ['a'],
            ['b']
          ]),
          frequency,
        );
        expect(analysis.sfbRating, 0.5);
      });

      test('layout is [[a], [b], [c]], output should be 1', () {
        final analysis = Analysis(
          getConfigFrom([
            ['a'],
            ['b'],
            ['c']
          ]),
          frequency,
        );
        expect(analysis.sfbRating, 1);
      });
    });
  });

  group('get inroll statistic', () {
    group('when corpus is "abcdefghi"', () {
      final frequency = Frequency('abcdefghi');

      test('when input layout is [["a"], ["e"]], output should be 0', () {
        final analysis = Analysis(
          getConfigFrom([
            ['a'],
            ['e']
          ]),
          frequency,
        );
        expect(analysis.inrollRating, 0);
      });

      test(
          'when input layout is [["a", "b"], ["e", "f"]],'
          ' output should be 0', () {
        final analysis = Analysis(
          getConfigFrom([
            ['a', 'b'],
            ['e', 'f']
          ]),
          frequency,
        );
        expect(analysis.inrollRating, 0);
      });

      test(
          'when input layout is [["a", "b" "c", "d"], ["e", "f", "g", "h"]],'
          ' output should be 0.25', () {
        final analysis = Analysis(
          getConfigFrom([
            ['a', 'b', 'c', 'd'],
            ['e', 'f', 'g', 'h']
          ]),
          frequency,
        );
        expect(analysis.inrollRating, 0.25);
      });

      test(
          'when input layout is [["a", "b" "d", "c"], ["e", "f", "h", "g"]],'
          ' output should be 0.5', () {
        final analysis = Analysis(
          getConfigFrom([
            ['a', 'b', 'd', 'c'],
            ['e', 'f', 'h', 'g']
          ]),
          frequency,
        );
        expect(analysis.inrollRating, 0.5);
      });
    });
  });

  group('get outroll statistic', () {
    group('when corpus is "lmnopqrstuv"', () {
      final frequency = Frequency('lmnopqrstuv');

      test('when input layout is [["l"], ["p"]], output should be 0', () {
        final analysis = Analysis(
          getConfigFrom([
            ['l'],
            ['p']
          ]),
          frequency,
        );
        expect(analysis.outrollRating, 0);
      });

      test(
          'when input layout is [["l", "m"], ["p", "q"]],'
          ' output should be 0', () {
        final analysis = Analysis(
          getConfigFrom([
            ['l', 'm'],
            ['p', 'q']
          ]),
          frequency,
        );
        expect(analysis.outrollRating, 0);
      });

      test(
          'when input layout is [["l", "m" "n", "o"], ["p", "q", "r", "s"]],'
          ' output should be 0.2', () {
        final analysis = Analysis(
          getConfigFrom([
            ['l', 'm', 'n', 'o'],
            ['p', 'q', 'r', 's']
          ]),
          frequency,
        );
        expect(analysis.outrollRating, 0.2);
      });

      test(
          'when input layout is [["m", "l" "n", "o"], ["q", "p", "r", "s"]],'
          ' output should be 0.4', () {
        final analysis = Analysis(
          getConfigFrom([
            ['m', 'l', 'n', 'o'],
            ['q', 'p', 'r', 's']
          ]),
          frequency,
        );
        expect(analysis.outrollRating, 0.4);
      });
    });
  });

  group('get effort rating', () {
    group('when corpus is "abcdefghg', () {
      final frequency = Frequency('abcdefgg');

      test(
          'and effortMatrix is [[1]], layout is [[a]], fingerMap is [[0]], '
          'output should be 0.125', () {
        final analysis = Analysis(
          Config([
            ['a']
          ], [
            [1]
          ], [
            [0]
          ]),
          frequency,
        );
        expect(analysis.effortRating, 0.125);
      });

      test(
          'and effortMatrix is [[2]], layout is [[a]], fingerMap is [[0]], '
          'output should be 0.25', () {
        final analysis = Analysis(
          Config([
            ['a']
          ], [
            [2]
          ], [
            [0]
          ]),
          frequency,
        );
        expect(analysis.effortRating, 0.25);
      });

      test(
          'and effortMatrix is [[1]], layout is [[g]], '
          'fingerMap is [[0]], output should be 0.25', () {
        final analysis = Analysis(
          Config([
            ['g']
          ], [
            [1]
          ], [
            [0]
          ]),
          frequency,
        );
        expect(analysis.effortRating, 0.25);
      });

      test(
          'and effortMatrix is [[1, 1]], layout is [[a, b]], '
          'fingerMap is [[0, 1]], output should be 0.25', () {
        final analysis = Analysis(
          Config([
            ['a', 'b']
          ], [
            [1, 1]
          ], [
            [0, 1]
          ]),
          frequency,
        );
        expect(analysis.effortRating, 0.25);
      });

      test(
          'and effortMatrix is [[1], [1]], layout is [[a], [b]], '
          'fingerMap is [[0], [1]], output should be 0.25', () {
        final analysis = Analysis(
          Config([
            ['a'],
            ['b']
          ], [
            [1],
            [1]
          ], [
            [0],
            [1]
          ]),
          frequency,
        );
        expect(analysis.effortRating, 0.25);
      });
    });
  });

  group('get finger effort', () {
    group('when corpus is "abcdefgg', () {
      final frequency = Frequency('abcdefgg');
      test(
        'when effortMatrix is [[1]], finger map is [[0]], layout is [[a]] '
        'output should be {0: 0.125}',
        () {
          final analysis = Analysis(
            Config([
              ['a']
            ], [
              [1]
            ], [
              [0]
            ]),
            frequency,
          );
          expect(analysis.fingerEffort, equals({0: 0.125}));
        },
      );

      test(
        'when effortMatrix is [[1, 1]], finger map is [[0, 1]], '
        'layout is [[a, b]], output should be {0: 0.125, 1: 0.125}',
        () {
          final analysis = Analysis(
            Config([
              ['a', 'b']
            ], [
              [1, 1]
            ], [
              [0, 1]
            ]),
            frequency,
          );
          expect(analysis.fingerEffort, equals({0: 0.125, 1: 0.125}));
        },
      );

      test(
        'when effortMatrix is [[1, 1]], finger map is [[0, 0]], '
        'layout is [[a, b]], output should be {0: 0.25}',
        () {
          final analysis = Analysis(
            Config([
              ['a', 'b']
            ], [
              [1, 1]
            ], [
              [0, 0]
            ]),
            frequency,
          );
          expect(analysis.fingerEffort, equals({0: 0.25}));
        },
      );

      test(
        'when effortMatrix is [[1]], finger map is [[0]], '
        'layout is [[g]], output should be {0: 0.25}',
        () {
          final analysis = Analysis(
            Config([
              ['g']
            ], [
              [1]
            ], [
              [0]
            ]),
            frequency,
          );
          expect(analysis.fingerEffort, equals({0: 0.25}));
        },
      );

      test(
        'when effortMatrix is [[1], [1]], finger map is [[0], [0]], '
        'layout is [[f], [g]], output should be {0: 0.375}',
        () {
          final analysis = Analysis(
            Config([
              ['f'],
              ['g']
            ], [
              [1],
              [1]
            ], [
              [0],
              [0]
            ]),
            frequency,
          );
          expect(analysis.fingerEffort, equals({0: 0.375}));
        },
      );

      test(
        'when effortMatrix is [[1], [2]], finger map is [[0], [1]], '
        'layout is [[f], [g]], output should be {0: 0.125, 1:0.5}',
        () {
          final analysis = Analysis(
            Config([
              ['f'],
              ['g']
            ], [
              [1],
              [2]
            ], [
              [0],
              [1]
            ]),
            frequency,
          );
          expect(analysis.fingerEffort, equals({0: 0.125, 1: 0.5}));
        },
      );
    });
  });

  group('get character repeat effort', () {
    group('when corpus is "aa"', () {
      final frequency = Frequency('aa');
      test(
          'and layout is [[b]], effortMatrix is [[1]], '
          'output should be 0', () {
        final analysis = Analysis(
          Config([
            ['b']
          ], [
            [1]
          ], [
            [0]
          ]),
          frequency,
        );
        expect(analysis.characterRepeatEffort, 0);
      });

      test(
          'and layout is [[a]], effortMatrix is [[1]], '
          'output should be 1', () {
        final analysis = Analysis(
          Config([
            ['a']
          ], [
            [1]
          ], [
            [0]
          ]),
          frequency,
        );
        expect(analysis.characterRepeatEffort, 1);
      });
    });

    group('when corpus is "aabbc"', () {
      final frequency = Frequency('aabbc');
      test(
          'and layout is [[a, b]], effortMatrix is [[1, 1]], '
          'output should be 0', () {
        final analysis = Analysis(
          Config([
            ['a', 'b']
          ], [
            [1, 1]
          ], [
            [0, 0]
          ]),
          frequency,
        );
        expect(analysis.characterRepeatEffort, 0.5);
      });

      test(
          'and layout is [[a, b]], effortMatrix is [[1, 2]], '
          'output should be 0.75', () {
        final analysis = Analysis(
          Config([
            ['a', 'b']
          ], [
            [1, 2]
          ], [
            [0, 0]
          ]),
          frequency,
        );
        expect(analysis.characterRepeatEffort, 0.75);
      });

      test(
          'and layout is [[a], [b]], effortMatrix is [[1], [2]], '
          'output should be 0.75', () {
        final analysis = Analysis(
          Config([
            ['a'],
            ['b']
          ], [
            [1],
            [2]
          ], [
            [0],
            [0]
          ]),
          frequency,
        );
        expect(analysis.characterRepeatEffort, 0.75);
      });
    });
  });

  group('get top ten sfb', () {
    group('when corpus is abcdefghi', () {
      final frequency = Frequency('abcdefghi');
      test(
        'when layout is [[a, b]], fingerIdMap is [[0, 0]], '
        'output should be ',
        () {
          final analysis = Analysis(
            Config([
              ['a', 'b'],
            ], [
              [1, 1],
            ], [
              [0, 0],
            ]),
            frequency,
          );
          expect(analysis.topSfb, equals({}));
        },
      );

      test(
        'when layout is [[a, b], [c, d]], fingerIdMap is [[0, 0], [1, 1]], '
        'output should be ',
        () {
          final analysis = Analysis(
            Config([
              ['a', 'b'],
              ['c', 'd']
            ], [
              [1, 1],
              [1, 1]
            ], [
              [0, 0],
              [1, 1]
            ]),
            frequency,
          );
          expect(analysis.topSfb, equals({'ab': 0.125, 'cd': 0.125}));
        },
      );

      test(
        'when layout is [[a, b], [c, d]], fingerIdMap is [[0, 0], [1, 1]], '
        'output should be {ab: 0.125, cd: 0.125}',
        () {
          final analysis = Analysis(
            Config([
              ['a', 'b'],
              ['c', 'd']
            ], [
              [1, 1],
              [1, 1]
            ], [
              [0, 0],
              [1, 1]
            ]),
            frequency,
          );
          expect(analysis.topSfb, equals({'ab': 0.125, 'cd': 0.125}));
        },
      );

      test(
        'when layout is [[a, b, c, d], [e, f, g, h]], '
        'fingerIdMap is [[0, 1, 2, 3], [0, 1, 2, 3]], output should be ',
        () {
          final analysis = Analysis(
            Config([
              ['a', 'b', 'c', 'd'],
              ['e', 'f', 'g', 'h']
            ], [
              [1, 1, 1, 1],
              [1, 1, 1, 1]
            ], [
              [0, 0, 0, 0],
              [1, 1, 1, 1],
            ]),
            frequency,
          );
          expect(analysis.topSfb, equals({'ab': 0.125, 'cd': 0.125}));
        },
      );
    });
  });
}
