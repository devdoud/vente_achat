import 'package:achat_vente/core/widgets/export.dart';

class IosClickable implements IClickable {
  @override
  Widget render(ITheme theme, Widget widget, void Function() onClick) {
    return InkWell(onTap: onClick, child: widget);
  }
}
