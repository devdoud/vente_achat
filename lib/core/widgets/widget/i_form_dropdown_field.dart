import '../export.dart';

abstract class IFormDropdownField {
  Widget render(
    ITheme theme,
    BuildContext context,
    IFormTextFieldType type,
    String name, {
    List<dynamic> items,
    String? label,
    String? hint,
    dynamic initialValue,
    bool required = true,
    void Function(dynamic)? onChanged,
    FormFieldValidator<dynamic>? validator,
  });
}
