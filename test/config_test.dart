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
            [1],
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
        'should return normally', () {
      expect(
        () => Config(
          [
            ['a'],
            ['b']
          ],
          [
            [1],
            [1]
          ],
          [
            [0],
            [1]
          ],
        ),
        returnsNormally,
      );
    });

    group('effort matrix must not contain values less than 1', () {
      test('when effort matrix is [[0]], throw assertionError', () {
        expect(
          () => Config(
            [
              ['a'],
            ],
            [
              [0],
            ],
            [
              [0],
            ],
          ),
          throwsAssertionError,
        );
      });

      test('when effort matrix is [[1, 0]], throw assertionError', () {
        expect(
          () => Config(
            [
              ['a', 'b'],
            ],
            [
              [1, 0],
            ],
            [
              [0, 0],
            ],
          ),
          throwsAssertionError,
        );
      });

      test('when effort matrix is [[1], [0]], throw assertionError', () {
        expect(
          () => Config(
            [
              ['a'],
              ['b'],
            ],
            [
              [1],
              [0],
            ],
            [
              [0],
              [0],
            ],
          ),
          throwsAssertionError,
        );
      });

      test('when effort matrix is [[0.9]], throw assertionError', () {
        expect(
          () => Config(
            [
              ['a'],
            ],
            [
              [0.9],
            ],
            [
              [0],
            ],
          ),
          throwsAssertionError,
        );
      });

      test('when effort matrix is [[1.3]], should return normally', () {
        expect(
          () => Config(
            [
              ['a'],
            ],
            [
              [1.9],
            ],
            [
              [0],
            ],
          ),
          returnsNormally,
        );
      });
    });

    group('finger map must be > 1', () {
      test('when finger map is [[-1]], should throw assertionError', () {
        expect(
          () => Config([
            ['a']
          ], [
            [1]
          ], [
            [-1]
          ]),
          throwsAssertionError,
        );
      });

      test('when finger map is [[0]], should return normally', () {
        expect(
          () => Config([
            ['a']
          ], [
            [1]
          ], [
            [0]
          ]),
          returnsNormally,
        );
      });

      test('when finger map is [[1], [-1]], should throw assertionError', () {
        expect(
          () => Config([
            ['a'],
            ['a']
          ], [
            [1],
            [1],
          ], [
            [1],
            [-1]
          ]),
          throwsAssertionError,
        );
      });

      test('when finger map is [[1, -1]], should throw assertionError', () {
        expect(
          () => Config([
            ['a', 'b'],
          ], [
            [1, 1],
          ], [
            [1, -1]
          ]),
          throwsAssertionError,
        );
      });
    });
  });
}
