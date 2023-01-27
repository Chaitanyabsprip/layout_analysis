const garbage = '   ';
typedef CountMap = Map<String, int>;

typedef NormalisedMap = Map<String, double>;

class Frequency {
  Frequency(this.corpus);

  final String corpus;

  final CountMap _ngramCount1 = {};
  final CountMap _ngramCount2 = {};

  CountMap ngramCount(int n) {
    if (n == 1 && _ngramCount1.isNotEmpty) {
      return _ngramCount1;
    }
    if (n == 2 && _ngramCount2.isNotEmpty) {
      return _ngramCount2;
    }

    if (corpus.isEmpty) return {};
    final ngrams = <String, int>{};
    final chars = corpus.trim().split('');
    for (var i = 0; i < chars.length - n + 1; i++) {
      final ngram = chars.sublist(i, i + n).join();
      ngrams[ngram] = (ngrams[ngram] ?? 0) + 1;
    }
    ngrams.removeWhere(
      (k, v) => k.contains(' ') || k.contains('\n') || k.contains('\t'),
    );
    if (n == 1) {
      _ngramCount1
        ..clear()
        ..addAll(ngrams);
    }
    if (n == 2) {
      _ngramCount2
        ..clear()
        ..addAll(ngrams);
    }
    return ngrams;
  }

  NormalisedMap ngramNormalised(int n) {
    if (corpus.isEmpty) return {};
    final ngrams = ngramCount(n);
    if (ngrams.isEmpty) return {};
    final total = ngrams.values.reduce((a, b) => a + b);
    return ngrams.map((key, value) => MapEntry(key, value / total));
  }
}
