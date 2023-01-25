import 'package:character_frequency_analysis/config.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('effort matrix, layout and finger map must have same shape', () {
    test(
        'when layout is [], effort matrix is [], '
        'and finger map is [] '
        'should throw assertionError', () {
      expect(
        () => Config([], [], []),
        throwsAssertionError,
      );
    });

    test(
        'when layout is [[]], effort matrix is [[]], '
        'and finger map is [[]] '
        'should throw assertionError', () {
      expect(
        () => Config([[]], [[]], [[]]),
        throwsAssertionError,
      );
    });

    test(
        'when layout is [[a]], effort matrix is [], '
        'and finger map is [] '
        'should throw assertionError', () {
      expect(
        () => Config(
          [
            ['a']
          ],
          [],
          [],
        ),
        throwsAssertionError,
      );
    });

    test(
        'when layout is [[a]], effort matrix is [[]], '
        'and finger map is [[]] '
        'should throw assertionError', () {
      expect(
        () => Config(
          [
            ['a']
          ],
          [<double>[]],
          [<int>[]],
        ),
        throwsAssertionError,
      );
    });

    test(
        'when layout is [[a], [b]], effort matrix is [[0], []], '
        'and finger map is [[0], []] '
        'should throw assertionError', () {
      expect(
        () => Config(
          [
            ['a'],
            ['b']
          ],
          [
            [0],
            []
          ],
          [
            [0],
            []
          ],
        ),
        throwsAssertionError,
      );
    });

    test(
        'when layout is [[a], [b]], effort matrix is [[0], [0]], '
        'and finger map is [[0], [0]] '
        'should throw assertionError', () {
      expect(
        () => Config(
          [
            ['a'],
            ['b']
          ],
          [
            [0],
            [0]
          ],
          [
            [0],
            [0]
          ],
        ),
        returnsNormally,
      );
    });
  });
}
