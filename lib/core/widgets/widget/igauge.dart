import '../export.dart';

abstract class ICircleIconGauge {
  Widget render(
    ITheme theme, {
    required double percentage,
    required Widget icon,
  });
}
