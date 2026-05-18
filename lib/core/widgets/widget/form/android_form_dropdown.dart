import 'package:achat_vente/export.dart';

class AndroidFormDropdownField extends IFormDropdownField {
  @override
  Widget render(
    ITheme theme,
    BuildContext context,
    IFormTextFieldType type,
    String name, {
    List<dynamic> items = const [],
    String? label,
    String? hint,
    initialValue,
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

        FormBuilderField(
          name: name,
          validator:
              validators.isNotEmpty
                  ? FormBuilderValidators.compose(validators)
                  : null,
          initialValue: initialValue,
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: InputDecoration(
                hintText: hint,
                fillColor: Colors.white,
                filled: true,
                hintStyle: context.theme.textTheme.titleSmall!.copyWith(
                  color: context.theme.colorScheme.secondary.withAlpha(150),
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: DropdownButton<dynamic>(
                isExpanded: true,
                value: field.value,
                underline: Container(),
                items:
                    items.map((item) {
                      return DropdownMenuItem<dynamic>(
                        value: item,
                        child: Text(item.toString()),
                      );
                    }).toList(),
                onChanged: (dynamic value) {
                  field.didChange(value);
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
