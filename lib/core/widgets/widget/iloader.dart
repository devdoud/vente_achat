import '../export.dart';

enum ILoaderType { circle, linear }

abstract class ILoader {
  Widget render(ITheme theme, ILoaderType type, {Color? color});
}
