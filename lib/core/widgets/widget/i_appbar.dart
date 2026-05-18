import '../export.dart';

enum IAppBarType { sliver, normal }

abstract class IAppBar {
  Widget render(
    ITheme theme,
    IAppBarType type, {
    List<Widget>? actions,
    Widget? title,
    bool? forceElevated,
    double? elevation,
    bool? implyLeading,
  });
}
