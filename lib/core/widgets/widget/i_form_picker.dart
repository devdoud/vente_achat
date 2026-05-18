import '../export.dart';

enum IFormFilePickerFieldType { image, video, audio, document, other }

abstract class IFormFilePicker {
  Widget render(
    ITheme theme,
    BuildContext context,
    IFormFilePickerFieldType type,
    String name, {
    String? label,
    String? hint,
    List<dynamic>? initialValue,
    int maxImages = 1,
    bool required = true,
    void Function(dynamic)? onChanged,
    FormFieldValidator<dynamic>? validator,
  });
}
