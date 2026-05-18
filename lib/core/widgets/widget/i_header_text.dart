import '../export.dart';

enum ITitleSize { h1, h2, h3, h4, defaultSize }

abstract class ITitleText {
  Widget render(
    ITheme theme,
    ITitleSize size, {
    required String text,
    TextStyle? style,
  });
}
