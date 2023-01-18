import 'package:character_frequency_analysis/character_frequency_analysis.dart';
import 'package:test/test.dart';

// should be able to get unigram frequency in absolute number
// should be able to get unigram frequency in normalised form
// should be able to get unigram frequency in percentage form
// should be able to get bigram frequency in absolute number
// should be able to get bigram frequency in normalised form
// should be able to get bigram frequency in percentage form
// should be able to get finger wise sfb percentage
// should be able to get total sfb percentage
// should be able to get top ten sfb percentage

void main() {
  group('should be able to get unigram frequency in absolute number', () {
    test('when input is empty, output should be {}', () {
      final analyser = Analyser('');
      expect(analyser.characterFrequency, equals({}));
    });

    test('when input is "a", output should be {"a": 1}', () {
      final analyser = Analyser('a');
      expect(analyser.characterFrequency, equals({'a': 1}));
    });

    test('when input is "aa", output should be {"a": 2}', () {
      final analyser = Analyser('aa');
      expect(analyser.characterFrequency, equals({'a': 2}));
    });

    test('when input is "ba", output should be {"a": 1, "b": 1}', () {
      final analyser = Analyser('ba');
      expect(analyser.characterFrequency, equals({'a': 1, 'b': 1}));
    });

    test('when input is "a b", output should be {"a": 1, "b": 1}', () {
      final analyser = Analyser('a b');
      expect(analyser.characterFrequency, equals({'a': 1, 'b': 1}));
    });
  });
}
