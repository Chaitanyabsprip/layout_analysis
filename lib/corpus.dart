import 'dart:io';

const blacklistChars = [
  '',
  '\b',
  '\f',
  '\r',
  '\u0000',
  '\u0001',
  '\u0002',
  '\u0003',
  '\u0004',
  '\u0005',
  '\u0006',
  '\u0007',
  '\u000b',
  '\u000e',
  '\u000f',
  '\u0010',
  '\u0011',
  '\u0012',
  '\u0013',
  '\u0014',
  '\u0015',
  '\u0016',
  '\u0017',
  '\u0018',
  '\u0019',
  '\u001a',
  '\u001b',
  '\u001c',
  '\u001d',
  '\u001e',
  '\u001f',
];

class Corpus {
  Corpus(this.paths);

  final List<String> paths;

  bool _blacklisted(String path) {
    final blacklist = <String>[
      'bugfix',
      'feature',
      'refactor',
      'linux',
      'ios',
      'macos',
      'my_font_awesome',
      'my_font_awesome',
      'android',
      'windows',
      'pipeline',
      '.jpg',
      '.jpeg',
      '.svg',
      '.png',
      '.bmp',
      '.gif',
      '.wav',
      '.html',
      'mason/packages',
      '.scm',
      '.otf',
      '.ttf'
    ];
    return blacklist.any((e) => path.contains(e));
  }

  String load() {
    _prepare();
    // var count = 0;
    // final corpora = paths.fold('', (corpus, path) {
    //   print(++count * 100 ~/ paths.length);
    //   if (_blacklisted(path)) return corpus;
    //   print('reading $path');
    //   return corpus + _readFileAsString(path);
    // });
    return _readFileAsString(
      '/Users/chaitanyasharma/Projects/Languages/Dart/character_frequency_analysis/assets/corpus.txt',
    ).toLowerCase();
    // File(
    //   '/Users/chaitanyasharma/Projects/Languages/Dart/character_frequency_analysis/assets/corpus.txt',
    // ).writeAsString(corpora);
    // return corpora.toLowerCase();
  }

  String _readFileAsString(String path) {
    try {
      final readAsStringSync = File(path).readAsStringSync();
      // return String.fromCharCodes(
      //   readAsStringSync.codeUnits.where((code) => code <= 127),
      // );
      var c = readAsStringSync;
      for (final blacklisted in blacklistChars) {
        c = c.replaceAll(blacklisted, '');
      }
      return c;
    } on FileSystemException catch (_) {
      return '';
    }
  }

  void _prepare() {
    for (final path in List<String>.from(paths)) {
      final file = File(path);
      if (path.isEmpty || (file.isHidden && path != '.')) {
        paths.remove(path);
        continue;
      }
      final isDirectory =
          file.statSync().type == FileSystemEntityType.directory;
      if (isDirectory) _flattenDirectoryFiles(path);
    }
  }

  void _flattenDirectoryFiles(String path) {
    paths.remove(path);
    for (final file in Directory(path).listSync(recursive: true)) {
      if (file is File && !file.isHidden) paths.add(file.path);
    }
  }
}

extension IsHidden on FileSystemEntity {
  bool get isHidden => uri.pathSegments.any((e) => e.startsWith('.'));
}
