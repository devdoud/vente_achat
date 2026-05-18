import '../export.dart';

enum IButtonStyle { outlined, contained, text }

abstract class IButton {
  Widget render(
    ITheme theme,
    String text, {
    VoidCallback? onTap,
    IButtonStyle style = IButtonStyle.contained,
    Widget? leftIcon,
    Widget? rightIcon,
    ButtonStyle? buttonStyle,
  });
}
