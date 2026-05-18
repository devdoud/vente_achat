import '../export.dart';

abstract class IClickable {
  Widget render(ITheme theme, Widget widget, void Function() onClick);
}
