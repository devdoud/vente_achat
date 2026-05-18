import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:achat_vente/core/export.dart';

class AndroidFormTextField implements IFormTextField {
  @override
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
  }) {
    List<FormFieldValidator<String>> validators = [];
    if (required) {
      validators.add(FormBuilderValidators.required());
    }
    if (type == IFormTextFieldType.email) {
      validators.add(FormBuilderValidators.email());
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
        FormBuilderTextField(
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
          initialValue: initialValue,
          obscureText: obscureText || type == IFormTextFieldType.password,
          keyboardType:
              type == IFormTextFieldType.phone
                  ? TextInputType.phone
                  : TextInputType.text,
          validator:
              validators.isNotEmpty
                  ? FormBuilderValidators.compose(validators)
                  : null,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
