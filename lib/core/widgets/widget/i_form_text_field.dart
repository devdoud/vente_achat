import '../export.dart';

enum IFormTextFieldType { text, email, password, phone, number, photo }

abstract class IFormTextField {
  Widget render(
    ITheme theme,
    BuildContext context,
    IFormTextFieldType type,
    String name, {
    String? label,
    String? hint,
    String? initialValue,
    bool obscureText = false,
    bool required = true,
    void Function(String?)? onChanged,
    FormFieldValidator<String?>? validator,
  });
}
