import 'package:achat_vente/core/widgets/export.dart';

class AndroidLoader implements ILoader {
  @override
  Widget render(ITheme theme, ILoaderType type, {Color? color}) {
    switch (type) {
      case ILoaderType.linear:
        return const LinearProgressIndicator();
      case ILoaderType.circle:
        return CircularProgressIndicator(
          backgroundColor: color ?? theme.theme.primaryColor,
          strokeWidth: 2,
        );
    }
  }
}
