import 'package:character_frequency_analysis/layout.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('create layout', () {
    // every element in the list should be a list
    // every list in the list should be of same length
    // there should be at least one character in list
    // there should not be any repeated character

    test('when input it [], should throw assertionError', () {
      expect(() => Layout([]), throwsAssertionError);
    });

    test('when input it [[]], should throw assertionError', () {
      expect(() => Layout([[]]), throwsAssertionError);
    });

    test('when input it [[a], []], should throw assertionError', () {
      expect(
        () => Layout([
          ['a'],
          []
        ]),
        throwsAssertionError,
      );
    });

    test('when input it [[a], [a]], should throw assertionError', () {
      expect(
        () => Layout([
          ['a'],
          ['a'],
        ]),
        throwsAssertionError,
      );
    });

    test('when input it [[a], [b]], should returns normally', () {
      expect(
        () => Layout([
          ['a'],
          ['b'],
        ]),
        returnsNormally,
      );
    });
  });

  group('get sfb', () {
    test('when input is [[]], output should be ""', () {
      expect(
        Layout([
          ['a'],
        ]).sfb,
        listEquals(['']),
      );
    });

    test('when input is [[a], [b]], output should be ["ab", "ba"]', () {
      expect(
        Layout([
          ['a'],
          ['b'],
        ]).sfb,
        listEquals(['ab', 'ba']),
      );
    });

    test('when input is [[c], [v]], output should be ["cv", "vc"]', () {
      expect(
        Layout([
          ['c'],
          ['v'],
        ]).sfb,
        listEquals(['cv', 'vc']),
      );
    });

    test(
        'when input is [[c], [v], [x]], output should be '
        '["cv", "vc", "vx", "xv", "cx", "xc"]', () {
      expect(
        Layout([
          ['c'],
          ['v'],
          ['x'],
        ]).sfb,
        listEquals(['cv', 'vc', 'vx', 'xv', 'cx', 'xc']),
      );
    });
  });
}
