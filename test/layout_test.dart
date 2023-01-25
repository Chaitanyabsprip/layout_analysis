import 'package:character_frequency_analysis/layout.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('create layout', () {
    // every element in the list should be a list
    // every list in the list should be of same length
    // there should be at least one character in list
    // there should not be any repeated character

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

    test(
        'when input is [[a, b], [c, d], [e, f]], output should be '
        '["ac", "ca", "ae", "ea", "ce", "ec", '
        '"bd", "db", "bf", "fb", "df", "fd"]', () {
      expect(
        Layout([
          ['a', 'b'],
          ['c', 'd'],
          ['e', 'f'],
        ]).sfb,
        listEquals([
          'ac',
          'ca',
          'ae',
          'ea',
          'ce',
          'ec',
          'bd',
          'db',
          'bf',
          'fb',
          'df',
          'fd'
        ]),
      );
    });
  });

  group('get left hand keymaps', () {
    test('when the input is [[a, b], [c, d]], output should be [[a], [c]]', () {
      final keymap = Layout([
        ['a', 'b'],
        ['c', 'd']
      ]);
      expect(
        keymap.left,
        equals([
          ['a'],
          ['c']
        ]),
      );
    });

    test(
        'when the input is [[a, b, c, d], [e, f, g, h]], '
        'output should be [[a, b], [e, f]]', () {
      final keymap = Layout([
        ['a', 'b', 'c', 'd'],
        ['e', 'f', 'g', 'h']
      ]);
      expect(
        keymap.left,
        equals([
          ['a', 'b'],
          ['e', 'f']
        ]),
      );
    });
  });

  group('get right hand keymaps', () {
    test('when the input is [[a, b], [c, d]], output should be [[a], [c]]', () {
      final keymap = Layout([
        ['a', 'b'],
        ['c', 'd']
      ]);
      expect(
        keymap.right,
        equals([
          ['b'],
          ['d']
        ]),
      );
    });

    test(
        'when the input is [[a, b, c, d], [e, f, g, h]], '
        'output should be [[a, b], [e, f]]', () {
      final keymap = Layout([
        ['a', 'b', 'c', 'd'],
        ['e', 'f', 'g', 'h']
      ]);
      expect(
        keymap.right,
        equals([
          ['c', 'd'],
          ['g', 'h']
        ]),
      );
    });
  });

  group('get inroll bigrams', () {
    test('when input is [[a], [b]], output should be []', () {
      final keymap = Layout([
        ['a'],
        ['b']
      ]);
      expect(keymap.inrolls, equals([]));
    });

    test(
      'when input is [[a, b, c, d], [e, f, g, h]], output should be '
      '[ab, af, ef, eb, dc, dg, hg, hc]',
      () {
        final keymap = Layout([
          ['a', 'b', 'c', 'd'],
          ['e', 'f', 'g', 'h']
        ]);
        expect(
          keymap.inrolls,
          equals(['ab', 'ef', 'dc', 'hg']),
        );
      },
    );
  });

  group('get outroll bigrams', () {
    test('when input is [[a], [b]], output should be []', () {
      final keymap = Layout([
        ['a'],
        ['b']
      ]);
      expect(keymap.outrolls, equals([]));
    });

    test(
      'when input is [[a, b, c, d], [e, f, g, h]], output should be '
      '[ba, fe, cd, gh]',
      () {
        final keymap = Layout([
          ['a', 'b', 'c', 'd'],
          ['e', 'f', 'g', 'h']
        ]);
        expect(
          keymap.outrolls,
          equals(['ba', 'fe', 'cd', 'gh']),
        );
      },
    );
  });
}
