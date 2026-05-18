import 'package:achat_vente/core/widgets/export.dart';

class AndroidChip implements IChip {
  @override
  Widget render(
    ITheme theme,
    IChipType type, {
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(label),
        backgroundColor: type == IChipType.inactive ? Colors.grey : null,
      ),
    );
  }
}
