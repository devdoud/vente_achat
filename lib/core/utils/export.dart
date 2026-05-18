import 'dart:io';
import 'dart:math';

import 'package:achat_vente/export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_svg/flutter_svg.dart';

export 'errors.dart';
export 'failures.dart';
export 'value_objects.dart';
export 'value_validators.dart';

abstract class UseCase<S, T, Params> {
  Future<Either<S, T>> call(Params params);
}

class NoParams {}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  // random color
  static HexColor random() {
    final random = Random();
    return HexColor(
      "#${(random.nextDouble() * 0xFFFFFF).toInt().toRadixString(16).padLeft(6, '0')}",
    );
  }
}

//const baseDesignWidth= 430;
const baseDesignWidth = 385;

class Utils {
  static double emSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    return baseSize * width / baseDesignWidth;
  }
}

extension CommonX on BuildContext {
  ThemeData get theme => Theme.of(this);
  Size get mediaSize => MediaQuery.of(this).size;
  TextTheme get textTheme => Theme.of(this).textTheme;
  double emSize(double baseSize) => Utils.emSize(this, baseSize);
}

extension WidgetX on Widget {
  SliverToBoxAdapter get toSliver => SliverToBoxAdapter(child: this);
  Widget get centered => Center(child: this);
  Widget padding(EdgeInsets padding) => Padding(padding: padding, child: this);
  Widget positioned({
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) => Positioned(
    top: top,
    left: left,
    right: right,
    bottom: bottom,
    child: this,
  );
  Widget clipRRect(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  Widget sized(Size size) =>
      SizedBox(width: size.width, height: size.height, child: this);
  Widget visible(bool visible) => visible ? this : const SizedBox.shrink();
  InkWell onClick(
    GestureTapCallback? onTap, {
    double radius = 7,
    GestureLongPressCallback? onLongPress,
  }) => InkWell(
    onTap: onTap,
    onLongPress: onLongPress,
    radius: radius,
    borderRadius: BorderRadius.circular(radius),
    hoverDuration: const Duration(milliseconds: 50),
    child: this,
  );
}

extension StringX on String? {
  bool get nullOrEmpty => this == null || this!.isEmpty;
  String get getOrEmpty => this == null ? "" : this!;
  String get onlyDigit => getOrEmpty.replaceAll(RegExp('[^0-9]'), "");
  String ellipse(int length) =>
      this == null
          ? ""
          : (this!.length > length
              ? "${this!.substring(0, length)}..."
              : this!);
}

extension BoolX on bool? {
  bool get valueOrFalse => this.isNotNull ? this! : false;
}

extension IsNullX on dynamic {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}

extension IntX on int? {
  int get getOrZero => this == null ? 0 : this!;
}

extension DoubleX on double? {
  double get getOrZero => this == null ? 0 : this!;
}

class ClipWidget extends StatelessWidget {
  final Widget widget;
  final double radius;

  const ClipWidget({super.key, required this.widget, this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Utils.emSize(context, radius)),
      child: widget,
    );
  }
}

class SvgOrPicture extends StatelessWidget {
  final String? link;
  final File? file;
  final BoxFit? fit;
  final Color? color;
  final Size? size;

  const SvgOrPicture({
    super.key,
    required this.link,
    this.file,
    this.fit,
    this.color,
    this.size,
  });
  factory SvgOrPicture.imgNotAvailable() =>
      const SvgOrPicture(link: "assets/img/img_not_available.jpeg");
  factory SvgOrPicture.avatar() =>
      const SvgOrPicture(link: "assets/img/default_avatar.jpg");
  factory SvgOrPicture.deliveryAddress() =>
      const SvgOrPicture(link: "assets/svg/pin.svg");
  factory SvgOrPicture.file(File file, {BoxFit? fit}) =>
      SvgOrPicture(file: file, link: '', fit: fit);

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      return Material(
        //borderRadius: const BorderRadius.all(Radius.circular(95.0)),
        //clipBehavior: Clip.hardEdge,
        child: Image.file(file!, fit: BoxFit.cover),
      );
    }

    if (link == null || link!.isEmpty) {
      return const SizedBox(
        height: 40,
        width: 40,
        child: Center(child: Icon(Icons.broken_image, color: Colors.black38)),
      );
    }

    final colorFilter =
        color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn);

    if (link!.startsWith("assets/")) {
      return SizedBox.expand(
        child:
            link!.endsWith("svg")
                ? SvgPicture.asset(
                  link!,
                  fit: fit ?? BoxFit.contain,
                  colorFilter: colorFilter,
                  height: size?.height,
                  width: size?.width,
                )
                : Image.asset(link!, fit: fit ?? BoxFit.fitWidth),
      );
    }

    return SizedBox.expand(
      child:
          link!.endsWith("svg")
              ? SvgPicture.network(
                link!,
                fit: BoxFit.cover,
                colorFilter: colorFilter,
                height: size?.height,
                width: size?.width,
              )
              : CachedNetworkImage(
                imageUrl: link!,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(color: HexColor("f4f4f4")),
              ),
    );
  }
}

class CriticalFailure extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final NetworkFailure failure;

  const CriticalFailure({
    super.key,
    required this.message,
    this.onRetry,
    required this.failure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 10),
        Text(
          message,
          style: IWidgetsFactory.build().theme.theme.textTheme.labelMedium!
              .copyWith(
                color: IWidgetsFactory.build().theme.theme.colorScheme.error,
              ),
          textAlign: TextAlign.center,
        ),
        if (onRetry != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
            child: ElevatedButton(
              onPressed: onRetry,
              child: const Text("Réessayer"),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
