import 'package:achat_vente/core/widgets/export.dart';

class IosLoader implements ILoader {
  @override
  Widget render(ITheme theme, ILoaderType type, {Color? color}) {
    switch (type) {
      case ILoaderType.circle:
        return const CupertinoActivityIndicator();
      case ILoaderType.linear:
        return const CupertinoActivityIndicator();
    }
  }
}
