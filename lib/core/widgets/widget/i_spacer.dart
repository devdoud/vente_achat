import '../export.dart';

enum ISpacerAxis { horizontal, vertical }

abstract class ISpacer {
  Widget render(
    ITheme theme,
    double gap, {
    ISpacerAxis axis = ISpacerAxis.vertical,
  });
}
