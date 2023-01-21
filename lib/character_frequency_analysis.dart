const garbage = '   ';
typedef CountMap = Map<String, int>;

typedef PercentMap = Map<String, double>;

class Analyser {
  Analyser(this.corpus);

  final String corpus;

  Map<String, int> ngramCount(int n) {
    if (corpus.isEmpty) return {};
    final ngrams = <String, int>{};
    final chars = corpus.trim().split('');
    for (var i = 0; i < chars.length - n + 1; i++) {
      final ngram = chars.sublist(i, i + n).join();
      ngrams[ngram] = (ngrams[ngram] ?? 0) + 1;
    }
    return ngrams
      ..removeWhere(
        (k, v) => k.contains(' ') || k.contains('\n') || k.contains('\t'),
      );
  }

  Map<String, double> ngramNormalised(int n) {
    if (corpus.isEmpty) return {};
    final ngrams = ngramCount(n);
    if (ngrams.isEmpty) return {};
    final total = ngrams.values.reduce((a, b) => a + b);
    return ngrams.map((key, value) => MapEntry(key, value / total));
  }
}
