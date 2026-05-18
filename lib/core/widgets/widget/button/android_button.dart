import 'package:achat_vente/core/widgets/export.dart';

class AndroidButton implements IButton {
  @override
  Widget render(
    ITheme theme,
    String text, {
    VoidCallback? onTap,
    IButtonStyle style = IButtonStyle.contained,
    Widget? leftIcon,
    Widget? rightIcon,
    ButtonStyle? buttonStyle,
  }) {
    if (style == IButtonStyle.outlined) {
      return OutlinedButton(
        onPressed: onTap,
        style: buttonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leftIcon != null) ...[leftIcon, const SizedBox(width: 8)],
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            if (rightIcon != null) ...[const SizedBox(width: 8), rightIcon],
          ],
        ),
      );
    }

    if (style == IButtonStyle.text) {
      return TextButton(
        onPressed: onTap,
        style: buttonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leftIcon != null) ...[leftIcon, const SizedBox(width: 8)],
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            if (rightIcon != null) ...[const SizedBox(width: 8), rightIcon],
          ],
        ),
      );
    }

    return ElevatedButton(
      onPressed: onTap,
      style: buttonStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftIcon != null) leftIcon,
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          if (rightIcon != null) rightIcon,
        ],
      ),
    );
  }
}
