import '../export.dart';

enum IChipType { active, inactive }

abstract class IChip {
  Widget render(
    ITheme theme,
    IChipType type, {
    required String label,
    VoidCallback? onTap,
  });
}
