import 'package:achat_vente/core/widgets/export.dart';

class IosSpacer implements ISpacer {
  @override
  Widget render(
    ITheme theme,
    double gap, {
    ISpacerAxis axis = ISpacerAxis.vertical,
  }) {
    switch (axis) {
      case ISpacerAxis.vertical:
        return SizedBox(height: gap);
      case ISpacerAxis.horizontal:
        return SizedBox(width: gap);
    }
  }
}
