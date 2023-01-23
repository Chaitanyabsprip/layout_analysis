// should be able to get unigram frequency in absolute number
// should be able to get unigram frequency in normalised form
// should be able to get bigram frequency in absolute number
// should be able to get bigram frequency in normalised form
// should be able to get finger wise sfb normalised form
// should be able to get total sfb normalised form
// should be able to get top ten sfb normalised form

import 'package:character_frequency_analysis/frequency.dart';
import 'package:test/test.dart';

void main() {
  group('get unigram frequency', () {
    group('in absolute number', () {
      test('when input is empty, output should be {}', () {
        final frequency = Frequency('');
        expect(frequency.ngramCount(1), equals({}));
      });

      test('when input is "a", output should be {"a": 1}', () {
        final frequency = Frequency('a');
        expect(frequency.ngramCount(1), equals({'a': 1}));
      });

      test('when input is "aa", output should be {"a": 2}', () {
        final frequency = Frequency('aa');
        expect(frequency.ngramCount(1), equals({'a': 2}));
      });

      test('when input is "ba", output should be {"a": 1, "b": 1}', () {
        final frequency = Frequency('ba');
        expect(frequency.ngramCount(1), equals({'a': 1, 'b': 1}));
      });

      test('when input is "a b", output should be {"a": 1, "b": 1}', () {
        final frequency = Frequency('a b');
        expect(frequency.ngramCount(1), equals({'a': 1, 'b': 1}));
      });

      test('when input is "a\nb", output should be {"a": 1, "b": 1}', () {
        final frequency = Frequency('a\nb');
        expect(frequency.ngramCount(1), equals({'a': 1, 'b': 1}));
      });

      test('when input is "a\tb", output should be {"a": 1, "b": 1}', () {
        final frequency = Frequency('a\tb');
        expect(frequency.ngramCount(1), equals({'a': 1, 'b': 1}));
      });
    });

    group('in normalised form', () {
      test('when input is empty, output should be {}', () {
        final frequency = Frequency('');
        expect(frequency.ngramNormalised(1), equals({}));
      });

      test('when input is "a", output should be {"a": 1}', () {
        final frequency = Frequency('a');
        expect(frequency.ngramNormalised(1), equals({'a': 1}));
      });

      test('when input is "ab", output should be {"a": 0.5, "b": 0.5}', () {
        final frequency = Frequency('ab');
        expect(frequency.ngramNormalised(1), equals({'a': 0.5, 'b': 0.5}));
      });

      test('when input is "a\nb", output should be {"a": 0.5, "b": 0.5}', () {
        final frequency = Frequency('a\nb');
        expect(frequency.ngramNormalised(1), equals({'a': 0.5, 'b': 0.5}));
      });

      test('when input is "a\tb", output should be {"a": 0.5, "b": 0.5}', () {
        final frequency = Frequency('a\tb');
        expect(frequency.ngramNormalised(1), equals({'a': 0.5, 'b': 0.5}));
      });

      test('when input is "a ", output should be {"a": 1}', () {
        final frequency = Frequency('a ');
        expect(frequency.ngramNormalised(1), equals({'a': 1}));
      });

      test('when input is "aba", output should be {"a": 0.67, "b": 0.33}', () {
        final frequency = Frequency('aba');
        expect(frequency.ngramNormalised(1), equals({'a': 2 / 3, 'b': 1 / 3}));
      });
    });
  });

  group('get bigram frequency', () {
    group('in absolute number', () {
      test('when input is "ab", output should be {"ab": 1}', () {
        final frequency = Frequency('ab');
        expect(frequency.ngramCount(2), equals({'ab': 1}));
      });

      test('when input is "ac", output should be {"ac": 1}', () {
        final frequency = Frequency('ac');
        expect(frequency.ngramCount(2), equals({'ac': 1}));
      });

      test('when input is "a c", output should be {}', () {
        final frequency = Frequency('a c');
        expect(frequency.ngramCount(2), equals({}));
      });

      test('when input is "abc", output should be {"ab":1,"bc":1}', () {
        final frequency = Frequency('abc');
        expect(frequency.ngramCount(2), equals({'ab': 1, 'bc': 1}));
      });

      test('when input is "abcabc", output should be {"ab":2,"bc":2, "ca":1}',
          () {
        final frequency = Frequency('abcabc');
        expect(frequency.ngramCount(2), equals({'ab': 2, 'bc': 2, 'ca': 1}));
      });

      test('when input is "a\nb", output should be {}', () {
        final frequency = Frequency('a\nb');
        expect(frequency.ngramCount(2), equals({}));
      });

      test('when input is "a\tb", output should be {}', () {
        final frequency = Frequency('a\tb');
        expect(frequency.ngramCount(2), equals({}));
      });

      test('when input is "  ", output should be {}', () {
        final frequency = Frequency('  ');
        expect(frequency.ngramNormalised(2), equals({}));
      });

      test('when input is "\t\t", output should be {}', () {
        final frequency = Frequency('\t\t');
        expect(frequency.ngramNormalised(2), equals({}));
      });
    });

    group('in normalised form', () {
      test('when input is empty, output should be {}', () {
        final frequency = Frequency('');
        expect(frequency.ngramNormalised(2), equals({}));
      });

      test('when input is "a", output should be {}', () {
        final frequency = Frequency('a');
        expect(frequency.ngramNormalised(2), equals({}));
      });

      test('when input is "ab", output should be {"ab": 1}', () {
        final frequency = Frequency('ab');
        expect(frequency.ngramNormalised(2), equals({'ab': 1}));
      });

      test('when input is "a ", output should be {}', () {
        final frequency = Frequency('a ');
        expect(frequency.ngramNormalised(2), equals({}));
      });

      test('when input is "a b", output should be {}', () {
        final frequency = Frequency('a b');
        expect(frequency.ngramNormalised(2), equals({}));
      });

      test('when input is "a\nb", output should be {}', () {
        final frequency = Frequency('a\nb');
        expect(frequency.ngramNormalised(2), equals({}));
      });

      test('when input is "a\tb", output should be {}', () {
        final frequency = Frequency('a\tb');
        expect(frequency.ngramNormalised(2), equals({}));
      });

      test('when input is "aba", output should be {"ab": 0.67, "ba": 0.33}',
          () {
        final frequency = Frequency('aba');
        expect(frequency.ngramNormalised(2), equals({'ab': 0.5, 'ba': 0.5}));
      });

      test('when input is "  ", output should be {}', () {
        final frequency = Frequency('  ');
        expect(frequency.ngramNormalised(2), equals({}));
      });

      test('when input is "\t\t", output should be {}', () {
        final frequency = Frequency('\t\t');
        expect(frequency.ngramNormalised(2), equals({}));
      });
    });
  });
}
