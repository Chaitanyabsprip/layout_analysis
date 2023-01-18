class Analyser {
  Analyser(this.content);
  final String content;
  Map<String, int> get characterFrequency {
    if (content.isEmpty) return {};
    return content
        .split('')
        .asMap()
        .map((k, v) => MapEntry(v, content.split(v).length - 1))
      ..remove(' ');
  }
}
