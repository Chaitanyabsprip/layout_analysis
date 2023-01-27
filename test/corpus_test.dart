import 'package:character_frequency_analysis/corpus.dart';
import 'package:test/test.dart';

void main() {
  group('load content of file', () {
    test('when input is empty, should throw assertionError', () {
      expect(Corpus(['']).load(), '');
    });

    test(
        'when input is "test.file1, empty string", should throw assertionError',
        () {
      expect(Corpus(['test.file1', '']).load(), '');
    });

    test(r'when input is "test.file1", output should be test1\n', () {
      final corpus = Corpus(['test/fixtures/test.file1']);
      expect(corpus.load(), 'test1\n');
    });

    test(r'when input is "test.file2", output should be test2\n', () {
      final corpus = Corpus(['test/fixtures/test.file2']);
      expect(corpus.load(), 'test2\n');
    });

    test(
        'when input is "test.file1, test.file2", output should be concatenated',
        () {
      final corpus =
          Corpus(['test/fixtures/test.file1', 'test/fixtures/test.file2']);
      expect(corpus.load(), 'test1\ntest2\n');
    });

    test(
        'when input is "test.directory1", output should be concatenated string '
        'for all contained files', () {
      final corpus = Corpus(['test/fixtures/test.directory1']);
      expect(corpus.load(), 'test1\ntest2\n');
    });

    test(
        'when input is "test.directory2", output should be concatenated string '
        'for all contained files recursively', () {
      final corpus = Corpus(['test/fixtures/test.directory2']);
      expect(corpus.load().split(''), containsAll(['1', '2', '3', '4']));
    });

    test("when input file doesn't exist, output should be ''", () {
      final corpus = Corpus(['test/fixtures/test.invalidFile']);
      expect(corpus.load(), '');
    });

    test("when input directory doesn't exist, output should be ''", () {
      final corpus = Corpus(['test/fixtures/test.invalidDirectory']);
      expect(corpus.load(), '');
    });
  });

  group('ignore hidden files', () {
    test('when input is .test.hiddenFile, output should be ""', () {
      final corpus = Corpus(['test/fixtures/.test.hiddenFile']);
      expect(corpus.load(), '');
    });

    test('when input is .test.hiddenDirectory, output should be ""', () {
      final corpus = Corpus(['test/fixtures/.test.hiddenDirectory']);
      expect(corpus.load(), '');
    });

    test('when input is .test.hiddenDirectory/test.file1, output should be ""',
        () {
      final corpus = Corpus(['test/fixtures/.test.hiddenDirectory/test.file1']);
      expect(corpus.load(), '');
    });

    test('when input is ".", output should consider current directory files',
        () {
      final corpus = Corpus(['.']);
      expect(corpus.load(), isNotEmpty);
    });

    test(
        'when input directory has a hidden directory inside, output should not '
        'consider the hidden directory', () {
      final corpus = Corpus(['test/fixtures/test.containsHiddenDirectory']);
      expect(corpus.load(), '');
    });
  });
}
