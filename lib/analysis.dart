import 'frequency.dart';
import 'keymap.dart';

class Analysis {
  Analysis(this.layout, this.frequency);

  final Layout layout;
  final Frequency frequency;

  double get sfbRating {
    if (layout.keymap.length < 2) return 0;
    final ngramNormalised = frequency.ngramNormalised(2);
    return layout.sfb.fold(
      0,
      (rating, sfb) => (ngramNormalised[sfb] ?? 0) + rating,
    );
  }
}
