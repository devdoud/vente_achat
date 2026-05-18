import '../export.dart';

class MaterialWidgetsFactory extends IWidgetsFactory {
  static final MaterialWidgetsFactory _instance =
      MaterialWidgetsFactory._internal();
  factory MaterialWidgetsFactory() {
    return _instance;
  }
  MaterialWidgetsFactory._internal();

  @override
  String getTitle() {
    return 'Android widgets';
  }

  @override
  ITheme get theme => DefaultTheme();

  @override
  ILoader get loaderWidget => AndroidLoader();

  @override
  ITitleText get loaderTitle => AndroidTitleText();

  @override
  IChip get loaderChip => AndroidChip();

  @override
  ICircleIconGauge get loaderCircleIconGauge => AndroidCircleIconGauge();

  @override
  ISpacer get spacerWidget => AndroidSpacer();

  @override
  IGridView get gridViewWidget => AndroidGridview();

  @override
  IAppBar get appBarWidget => AndroidAppBar();

  @override
  IButton get buttonWidget => AndroidButton();

  @override
  IFormTextField get formTextFieldWidget => AndroidFormTextField();

  @override
  IFormFilePicker get formFilePickerWidget => AndroidFormFilePicker();

  @override
  IFormDropdownField get formDropdownFieldWidget => AndroidFormDropdownField();
}
