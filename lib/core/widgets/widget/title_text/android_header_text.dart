import 'package:achat_vente/core/widgets/export.dart';

class AndroidTitleText implements ITitleText {
  @override
  Widget render(
    ITheme theme,
    ITitleSize size, {
    required String text,
    TextStyle? style,
  }) {
    return Text(text, style: style ?? theme.theme.textTheme.bodyMedium);
  }
}
