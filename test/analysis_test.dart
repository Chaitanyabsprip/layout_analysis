import 'package:character_frequency_analysis/analysis.dart';
import 'package:character_frequency_analysis/frequency.dart';
import 'package:character_frequency_analysis/layout.dart';
import 'package:test/test.dart';

void main() {
  // for analysis, I need the frequency of ngrams, for that I need a corpus
  // for analysis, I also need the layout.

  group('get single finger bigram(SFB)', () {
    group('when corpus is "abc", ', () {
      final frequency = Frequency('abc');

      test('layout is [[a]], output should be 0', () {
        final analysis = Analysis(
          Layout([
            ['a']
          ]),
          frequency,
        );
        expect(analysis.sfbRating, 0);
      });

      test('layout is [[a], [b]], output should be 0.5', () {
        final analysis = Analysis(
          Layout([
            ['a'],
            ['b']
          ]),
          frequency,
        );
        expect(analysis.sfbRating, 0.5);
      });

      test('layout is [[a], [b], [c]], output should be 1', () {
        final analysis = Analysis(
          Layout([
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
          Layout([
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
          Layout([
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
        print(frequency.ngramNormalised(2));
        final analysis = Analysis(
          Layout([
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
        print(frequency.ngramNormalised(2));
        final analysis = Analysis(
          Layout([
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
    group('when corpus is "abcdefghi"', () {
      final frequency = Frequency('lmnopqrstuv');
      print(frequency.ngramNormalised(2));

      test('when input layout is [["l"], ["p"]], output should be 0', () {
        final analysis = Analysis(
          Layout([
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
          Layout([
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
        print(frequency.ngramNormalised(2));
        final analysis = Analysis(
          Layout([
            ['l', 'm', 'n', 'o'],
            ['p', 'q', 'r', 's']
          ]),
          frequency,
        );
        expect(analysis.outrollRating, 0.2);
      });

      test(
          'when input layout is [["l", "m" "n", "o"], ["p", "q", "s", "t"]],'
          ' output should be 0.4', () {
        print(frequency.ngramNormalised(2));
        final analysis = Analysis(
          Layout([
            ['l', 'm', 'o', 'n'],
            ['p', 'q', 's', 'r']
          ]),
          frequency,
        );
        expect(analysis.outrollRating, 0.4);
      });
    });
  });
}
