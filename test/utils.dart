import 'package:test/test.dart';

final TypeMatcher<AssertionError> isAssertionError = isA<AssertionError>();
final Matcher throwsAssertionError = throwsA(isAssertionError);

Matcher listEquals(List<dynamic> expected) => _ListEquals(expected);

class _ListEquals extends Matcher {
  _ListEquals(this.expected);

  final List<dynamic> expected;

  @override
  Description describe(Description description) {
    return description.add('$expected');
  }

  @override
  bool matches(Object? actual, _) {
    return equals(expected).matches(actual, _) ||
        actual is List &&
            actual.length == expected.length &&
            actual.every(expected.contains);
  }
}
