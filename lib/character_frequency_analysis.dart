typedef CountMap = Map<String, int>;
typedef PercentMap = Map<String, double>;

class Analyser {
  Analyser(this.corpus);
  final String corpus;
  CountMap ngramCount(int n) {
    if (corpus.isEmpty) return {};
    if (n == 2) return _bigramCount;
    return _unigramCount;
  }

  PercentMap ngramNormalised(int n) {
    if (corpus.isEmpty) return {};
    if (n == 2) {
      final bigramCount = _bigramCount;
      final total =
          bigramCount.entries.fold(0, (sum, mapEntry) => mapEntry.value + sum);
      return bigramCount.map((k, v) => MapEntry(k, v / total));
    }
    final unigramCount = _unigramCount;
    final total =
        unigramCount.entries.fold(0, (sum, mapEntry) => mapEntry.value + sum);
    return unigramCount.map((k, v) => MapEntry(k, v / total));
  }

  CountMap get _unigramCount {
    return corpus
        .trim()
        .split('')
        .asMap()
        .map((k, v) => MapEntry(v, corpus.split(v).length - 1))
      ..remove(' ');
  }

  CountMap get _bigramCount {
    final chars = corpus.trim().split('');
    final temp = List<String>.from(chars);
    final map = chars.map((e) {
      final index = temp.indexOf(e);
      temp[index] = '   ';
      final nextChar = index < chars.length - 1 ? chars[index + 1] : '';
      return '$e$nextChar';
    }).where((element) => !element.contains(' '));
    return map.fold<CountMap>({}, (countMap, bigram) {
      countMap[bigram] = (countMap[bigram] ?? 0) + 1;
      return countMap;
    })
      ..removeWhere((key, value) => key.length < 2);
  }
}
