import 'package:achat_vente/core/export.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AndroidFormFilePicker extends IFormFilePicker {
  @override
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
    void Function(dynamic p1)? onChanged,
    FormFieldValidator? validator,
  }) {
    List<FormFieldValidator<dynamic>> validators = [];
    if (required) {
      validators.add(FormBuilderValidators.required());
    }
    if (validator != null) {
      validators.add(validator);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...{
          Text(
            label,
            style: context.theme.textTheme.titleSmall!.copyWith(
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          IWidgetsFactory.build().createSpacer(context.emSize(5)),
        },

        FormBuilderImagePicker(
          name: name,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: Colors.white,
            filled: true,
            hintStyle: context.theme.textTheme.titleSmall!.copyWith(
              color: context.theme.colorScheme.secondary.withAlpha(150),
              fontWeight: FontWeight.w400,
            ),
          ),
          showDecoration: false,
          previewAutoSizeWidth: false,
          fit: BoxFit.cover,
          initialValue: initialValue,
          maxImages: maxImages,
          validator:
              validators.isNotEmpty
                  ? FormBuilderValidators.compose(validators)
                  : null,
          onChanged: onChanged,
          transformImageWidget:
              (context, displayImage) => Card(
                clipBehavior: Clip.antiAlias,
                child: SizedBox.expand(child: displayImage),
              ),
        ),
      ],
    );
  }
}
