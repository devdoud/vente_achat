import 'dart:io';
import 'dart:math';
import 'package:achat_vente/export.dart';

abstract class IWidgetParams {}

enum UrlType { webPage, video }

abstract class IWidget {
  Widget render(ITheme theme, {IWidgetParams? param});
}

abstract class IWidgetsFactory {
  final List<IWidget> registered = [];

  IWidgetsFactory();

  factory IWidgetsFactory.build() {
    if (Platform.isAndroid) {
      return MaterialWidgetsFactory();
    } else {
      return MaterialWidgetsFactory();
    }
  }

  LinearGradient get defaultGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(105.27 * (pi / 180)), // convert to radians
    colors: [Color.fromRGBO(17, 132, 90, 1), Color.fromRGBO(22, 34, 51, 1)],
    stops: [0.0184, 1.1021],
  );

  String getTitle();

  ITheme get theme;
  ISpacer get spacerWidget;
  ILoader get loaderWidget;
  ITitleText get loaderTitle;
  IChip get loaderChip;
  ICircleIconGauge get loaderCircleIconGauge;
  IGridView get gridViewWidget;
  IAppBar get appBarWidget;
  IButton get buttonWidget;
  IFormTextField get formTextFieldWidget;
  IFormFilePicker get formFilePickerWidget;
  IFormDropdownField get formDropdownFieldWidget;

  Widget createFormTextField(
    BuildContext context, {
    required String name,
    IFormTextFieldType type = IFormTextFieldType.text,
    String? label,
    String? hint,
    String? initialValue,
    bool obscureText = false,
    bool required = true,
    void Function(String?)? onChanged,
    FormFieldValidator<String?>? validator,
  }) {
    return formTextFieldWidget.render(
      theme,
      context,
      type,
      name,
      hint: hint,
      initialValue: initialValue,
      label: label,
      obscureText: obscureText,
      required: required,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget createFormFilePicker(
    BuildContext context, {
    required String name,
    IFormFilePickerFieldType type = IFormFilePickerFieldType.image,
    String? label,
    String? hint,
    List<dynamic>? initialValue,
    int maxImages = 1,
    bool required = true,
    void Function(dynamic)? onChanged,
    FormFieldValidator<dynamic>? validator,
  }) {
    return formFilePickerWidget.render(
      theme,
      context,
      type,
      name,
      hint: hint,
      initialValue: initialValue,
      label: label,
      maxImages: maxImages,
      required: required,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget createFormDropdownField(
    BuildContext context, {
    required String name,
    required List<dynamic> items,
    String? label,
    String? hint,
    dynamic initialValue,
    bool required = true,
    void Function(dynamic)? onChanged,
    FormFieldValidator<dynamic>? validator,
  }) {
    return formDropdownFieldWidget.render(
      theme,
      context,
      IFormTextFieldType.text,
      name,
      items: items,
      hint: hint,
      initialValue: initialValue,
      label: label,
      required: required,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget createButton(
    String s, {
    required VoidCallback onPressed,
    IButtonStyle style = IButtonStyle.contained,
    Widget? leftIcon,
    Widget? rightIcon,
    ButtonStyle? buttonStyle,
  }) {
    return buttonWidget.render(
      theme,
      s,
      onTap: onPressed,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      style: style,
      buttonStyle: buttonStyle,
    );
  }

  Widget createLoader(ILoaderType type, {Color? color}) {
    return loaderWidget.render(theme, type, color: color ?? Colors.white60);
  }

  Widget createTitle(
    String text, {
    TextStyle? style,
    ITitleSize size = ITitleSize.defaultSize,
  }) {
    return loaderTitle.render(theme, size, text: text, style: style);
  }

  Widget createChip(IChipType type, String label, {VoidCallback? onTap}) {
    return loaderChip.render(theme, type, label: label, onTap: onTap);
  }

  Widget createCircleIconGauge(double percentage, Widget icon) {
    return loaderCircleIconGauge.render(
      theme,
      percentage: percentage,
      icon: icon,
    );
  }

  Widget createSpacer(double gap, {ISpacerAxis axis = ISpacerAxis.vertical}) {
    return spacerWidget.render(theme, gap, axis: axis);
  }

  Widget horizontalSpacer(double gap) {
    return spacerWidget.render(theme, gap, axis: ISpacerAxis.horizontal);
  }

  Widget verticalSpacer(double gap) {
    return spacerWidget.render(theme, gap);
  }

  Widget createGridView({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    IGridViewParam? param,
  }) {
    return gridViewWidget.render(
      theme,
      param ?? IGridViewParam(),
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }

  AppBar createAppBar({
    List<Widget>? actions,
    Widget? title,
    bool? forceElevated,
    double? elevation,
    bool? implyLeading,
  }) {
    return appBarWidget.render(
          theme,
          IAppBarType.normal,
          actions: actions,
          title: title,
          forceElevated: forceElevated,
          elevation: elevation,
          implyLeading: implyLeading,
        )
        as AppBar;
  }

  SliverAppBar createSilverAppBar({
    List<Widget>? actions,
    Widget? title,
    bool? forceElevated,
    double? elevation,
    bool? implyLeading,
  }) {
    return appBarWidget.render(
          theme,
          IAppBarType.sliver,
          actions: actions,
          title: title,
          forceElevated: forceElevated,
          elevation: elevation,
          implyLeading: implyLeading,
        )
        as SliverAppBar;
  }

  Widget render(IWidget widget, {IWidgetParams? param}) {
    return widget.render(theme, param: param);
  }

  void openUrl(
    BuildContext context,
    String url, {
    String? title,
    UrlType type = UrlType.webPage,
    bool replace = false,
  }) {
    AppLogger.get().logInfo("openUrl: $url - $type");
    if (type == UrlType.video) {
      _openVideo(context, url, title, replace: replace);
    } else {
      _openWebPage(context, url, title, replace: replace);
    }
  }

  void _openVideo(
    BuildContext context,
    String url,
    String? title, {
    bool replace = false,
  }) {
    if (replace) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => WebViewPage(url: url, title: title)),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => WebViewPage(url: url, title: title)),
      );
    }
  }

  void _openWebPage(
    BuildContext context,
    String url,
    String? title, {
    bool replace = false,
  }) {
    if (replace) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => WebViewPage(url: url, title: title)),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => WebViewPage(url: url, title: title)),
      );
    }
  }
}
