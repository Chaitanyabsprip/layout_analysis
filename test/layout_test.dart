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
        ], [
          [0],
          [0],
        ]),
        throwsAssertionError,
      );
    });

    test('when input it [[a], [b]], should returns normally', () {
      expect(
        () => Layout([
          ['a'],
          ['b'],
        ], [
          [0],
          [0],
        ]),
        returnsNormally,
      );
    });
  });

  group('get fingerKeyMap', () {
    test(
        'when layout is [[a]], fingerIdMap is [[0]], '
        'output should be {0: [a]}', () {
      expect(
        Layout([
          ['a']
        ], [
          [0]
        ]).fingerKeyMap,
        equals({
          0: ['a']
        }),
      );
    });

    test(
        'when layout is [[a, b]], fingerIdMap is [[0, 0]], '
        'output should be {0: [a, b]}', () {
      expect(
        Layout([
          ['a', 'b']
        ], [
          [0, 0]
        ]).fingerKeyMap,
        equals({
          0: ['a', 'b']
        }),
      );
    });

    test(
        'when layout is [[a, b]], fingerIdMap is [[0, 1]], '
        'output should be {0: [a], 1: [1]}', () {
      expect(
        Layout([
          ['a', 'b']
        ], [
          [0, 1]
        ]).fingerKeyMap,
        equals({
          0: ['a'],
          1: ['b']
        }),
      );
    });

    test(
        'when layout is [[a], [b]], fingerIdMap is [[0], [0]], '
        'output should be {0: [a, b]}', () {
      expect(
        Layout([
          ['a'],
          ['b']
        ], [
          [0],
          [0]
        ]).fingerKeyMap,
        equals({
          0: ['a', 'b'],
        }),
      );
    });

    test(
        'when layout is [[a], [b]], fingerIdMap is [[0], [1]], '
        'output should be {0: [a], 1: [b]}', () {
      expect(
        Layout([
          ['a'],
          ['b']
        ], [
          [0],
          [1]
        ]).fingerKeyMap,
        equals({
          0: ['a'],
          1: ['b'],
        }),
      );
    });

    test(
        'when layout is [[a, b], [c, d]], fingerIdMap is [[0, 1], [0, 1]], '
        'output should be {0: [a, c], 1: [b, d]}', () {
      expect(
        Layout([
          ['a', 'b'],
          ['c', 'd']
        ], [
          [0, 1],
          [0, 1]
        ]).fingerKeyMap,
        equals({
          0: ['a', 'c'],
          1: ['b', 'd'],
        }),
      );
    });
  });

  group('get sfb', () {
    test(
        'when layout is [[a]], fingerIdMap is [[0]], '
        'output should be {0: [a]}', () {
      expect(
        Layout([
          ['a']
        ], [
          [0]
        ]).fingerKeyMap,
        equals({
          0: ['a']
        }),
      );
    });
    test('when layout is [[a]], fingerIdMap is [[0]], output should be ""', () {
      expect(
        Layout(
          [
            ['a'],
          ],
          [
            [0]
          ],
        ).sfb,
        listEquals(['']),
      );
    });

    test(
        'when layout is [[a], [b]], fingerIdMap is [[0], [0]], '
        'output should be ["ab", "ba"]', () {
      expect(
        Layout([
          ['a'],
          ['b'],
        ], [
          [0],
          [0]
        ]).sfb,
        listEquals(['ab', 'ba']),
      );
    });

    test('when input is [[c], [v]], output should be ["cv", "vc"]', () {
      expect(
        Layout(
          [
            ['c'],
            ['v'],
          ],
          [
            [0],
            [0]
          ],
        ).sfb,
        listEquals(['cv', 'vc']),
      );
    });

    test(
        'when input is [[c], [v], [x]], output should be '
        '["cv", "vc", "vx", "xv", "cx", "xc"]', () {
      expect(
        Layout(
          [
            ['c'],
            ['v'],
            ['x'],
          ],
          [
            [0],
            [0],
            [0]
          ],
        ).sfb,
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
        ], [
          [0, 1],
          [0, 1],
          [0, 1],
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

    test(
        'when layout is [[a, b], [c, d]], fingerIdMap is [[1, 1], [1, 1]] '
        'output should be [ac, ca, bd, db, ad, ab, da, ba, bc, cb, cd, dc]',
        () {
      expect(
        Layout([
          ['a', 'b'],
          ['c', 'd'],
        ], [
          [1, 1],
          [1, 1],
        ]).sfb,
        listEquals([
          'ab',
          'ac',
          'ad',
          'ba',
          'bc',
          'bd',
          'ca',
          'cb',
          'cd',
          'da',
          'db',
          'dc',
        ]),
      );
    });
  });

  group('get left hand keymaps', () {
    test('when the input is [[a, b], [c, d]], output should be [[a], [c]]', () {
      final keymap = Layout([
        ['a', 'b'],
        ['c', 'd']
      ], [
        [0, 1],
        [0, 1]
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
      ], [
        [0, 1, 2, 3],
        [0, 1, 2, 3]
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
      ], [
        [0, 1],
        [0, 1],
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
      ], [
        [0, 1, 2, 3],
        [0, 1, 2, 3],
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
      ], [
        [0, 1],
        [0, 1],
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
        ], [
          [0, 1, 2, 3],
          [0, 1, 2, 3],
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
      ], [
        [0, 1, 2, 3],
        [0, 1, 2, 3],
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
        ], [
          [0, 1, 2, 3],
          [0, 1, 2, 3],
        ]);
        expect(
          keymap.outrolls,
          equals(['ba', 'fe', 'cd', 'gh']),
        );
      },
    );
  });
}
