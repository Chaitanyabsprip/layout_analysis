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

      test('layout is [[a], [b]], output should be 0.33', () {
        final analysis = Analysis(
          Layout([
            ['a'],
            ['b']
          ]),
          frequency,
        );
        expect(analysis.sfbRating, 1 / 3);
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
}
