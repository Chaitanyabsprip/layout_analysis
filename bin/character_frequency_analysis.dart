import 'package:character_frequency_analysis/analysis.dart';
import 'package:character_frequency_analysis/config.dart';
import 'package:character_frequency_analysis/corpus.dart';
import 'package:character_frequency_analysis/frequency.dart';

void main(List<String> arguments) {
  print(arguments);
  final corpus = Corpus(List<String>.from(arguments));
  final load = corpus.load();
  print('number of lines in corpus: ${load.split('\n').length}');
  print(
    'analysing ${load.split('\n').length} lines and ${load.length} '
    'total characters',
  );
  final frequency = Frequency(load);
  final keymap = <List<String>>[
    ['/', 'v', 'w', 'm', 'k', 'z', 'f', 'u', 'x', 'q'],
    ['a', 's', 'r', 't', 'g', 'p', 'n', 'e', 'o', 'i'],
    ['.', 'c', 'l', 'd', 'j', 'b', 'h', "'", ',', 'y'],
  ];
  final effortMatrix = <List<double>>[
    [3.2, 2.4, 2.0, 2.2, 3.2, 3.2, 2.2, 2.0, 2.4, 3.2],
    [1.6, 1.3, 1.1, 1.0, 2.9, 2.9, 1.0, 1.1, 1.3, 1.6],
    [3.0, 2.6, 2.3, 1.6, 3.0, 3.0, 1.6, 2.3, 2.6, 3.0]
  ];
  final fingerIdMap = <List<int>>[
    [0, 1, 2, 3, 3, 4, 4, 5, 6, 7],
    [0, 1, 2, 3, 3, 4, 4, 5, 6, 7],
    [0, 1, 2, 3, 3, 4, 4, 5, 6, 7],
  ];
  final analyser = Analysis(
    Config(keymap, effortMatrix, fingerIdMap),
    frequency,
  );

  print('sfb: ${analyser.sfbRating}');
  print('inroll: ${analyser.inrollRating}');
  print('outroll: ${analyser.outrollRating}');
  print('effortRating: ${analyser.effortRating}');
  print('fingerEffort: ${analyser.fingerEffort}');
  print('characterRepeatEffort: ${analyser.characterRepeatEffort}');
}
