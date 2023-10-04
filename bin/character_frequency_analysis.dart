import 'package:character_frequency_analysis/analysis.dart';
import 'package:character_frequency_analysis/config.dart';
import 'package:character_frequency_analysis/corpus.dart';
import 'package:character_frequency_analysis/frequency.dart';

void main(List<String> arguments) {
  print(arguments);
  final corpus = Corpus(List<String>.from(arguments));
  final load = corpus.load();
  print(
    'analysing ${load.split('\n').length} lines and ${load.length} '
    'total characters',
  );
  final frequency = Frequency(load);
  final keymap = <List<String>>[
    // current
    ['/', 'v', 'w', 'm', 'j', 'z', 'f', 'u', 'x', 'q'],
    ['a', 's', 'r', 't', 'g', 'p', 'n', 'e', 'o', 'i'],
    ['.', 'c', 'l', 'd', 'k', 'b', 'h', "'", ',', 'y'],
    // to be optimised
    // ["'", 'x', ',', 'b', 'q', '.', 'f', 'm', 'u', 'z'],
    // ['i', 'r', 'a', 't', 'g', 'p', 'c', 'n', 'e', 's'],
    // ['y', 'l', 'o', 'd', 'k', 'j', 'w', 'h', '/', 'v'],
    // sur rearranged
    // ['z', 'x', 'm', 'b', 'q', '.', 'f', 'o', 'u', "'"],
    // ['s', 'r', 'n', 't', 'g', 'p', 'c', 'a', 'e', 'i'],
    // ['v', 'l', 'h', 'd', 'k', 'j', 'w', ',', '/', 'y'],
    // siddhant
    // ["'", 'w', 'm', 'g', 'j', 'k', 'f', 'o', 'u', 'q'],
    // ['i', 'r', 's', 't', 'd', 'p', 'n', 'a', 'e', 'h'],
    // ['z', 'x', 'c', 'v', 'b', 'y', 'l', ',', '.', '/'],
    // gallium
    // ['b', 'l', 'd', 'c', 'v', 'z', 'y', 'o', 'u', ','],
    // ['n', 'r', 't', 's', 'g', 'f', 'h', 'a', 'e', 'i'],
    // ['q', 'x', 'm', 'w', 'j', 'k', 'p', "'", '/', '.'],
  ];

  final effortMatrix = <List<double>>[
    [3.0, 2.0, 1.5, 1.7, 3.2, 3.2, 1.7, 1.5, 2.0, 3.0],
    [1.6, 1.3, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 1.3, 1.6],
    [2.5, 1.8, 1.7, 1.3, 3.0, 3.0, 1.3, 1.7, 1.8, 2.5]
  ];
  final fingerIdMap = <List<int>>[
    [0, 1, 2, 3, 3, 4, 4, 5, 6, 7],
    [0, 1, 2, 3, 3, 4, 4, 5, 6, 7],
    [0, 1, 2, 3, 3, 4, 4, 5, 6, 7],
  ];

  Analysis(Config(keymap, effortMatrix, fingerIdMap), frequency).prettyPrint();
}
