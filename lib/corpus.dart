import 'dart:io';

class Corpus {
  Corpus(this.paths);

  final List<String> paths;

  String load() {
    _prepare();
    return paths.fold('', (corpus, path) => corpus + _readFileAsString(path));
  }

  String _readFileAsString(String path) {
    try {
      return File(path).readAsStringSync();
    } on FileSystemException catch (_) {
      return '';
    }
  }

  void _prepare() {
    for (final path in List<String>.from(paths)) {
      final file = File(path);
      final isDirectory =
          file.statSync().type == FileSystemEntityType.directory;
      if (isDirectory) _flattenDirectoryFiles(path);
    }
  }

  void _flattenDirectoryFiles(String path) {
    paths.remove(path);
    for (final file in Directory(path).listSync(recursive: true)) {
      if (file is File) paths.add(file.path);
    }
  }
}
