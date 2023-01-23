import 'frequency.dart';
import 'layout.dart';

class Analysis {
  Analysis(this.layout, this.frequency);

  final Layout layout;
  final Frequency frequency;

  double get inrollRating {
    if (layout.keymap.first.length < 2) return 0;
    final ngramNormalised = _ngramNormalised2;
    return layout.inrolls.fold(
      0,
      (rating, bigram) => (ngramNormalised[bigram] ?? 0) + rating,
    );
  }

  NormalisedMap get _ngramNormalised2 => frequency.ngramNormalised(2);

  double get sfbRating {
    if (layout.keymap.length < 2) return 0;
    final ngramNormalised = _ngramNormalised2;
    return layout.sfb.fold(
      0,
      (rating, sfb) => (ngramNormalised[sfb] ?? 0) + rating,
    );
  }
}
