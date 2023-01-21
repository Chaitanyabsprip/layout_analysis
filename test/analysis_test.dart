import 'package:character_frequency_analysis/analysis.dart';
import 'package:character_frequency_analysis/config.dart';
import 'package:test/test.dart';

void main() {
  group('get single finger bigram(SFB)', () {
    test('when input is [[]], output should be 0', () {
      final config = Config([[]], [[]]);
      final analysis = Analysis(config);
      expect(analysis.sfbRating, 0);
    });
  });
}
