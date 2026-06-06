import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'core/export.dart';

export 'package:auto_route/annotations.dart';
export 'package:auto_route/auto_route.dart' hide kCupertinoModalBarrierColor, CupertinoPageTransition, CupertinoFullscreenDialogTransition;
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_form_builder/flutter_form_builder.dart';
export 'package:form_builder_validators/form_builder_validators.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';

export 'core/export.dart';
// Hide conflicting symbol 'Order' exported from features to avoid ambiguity
export 'features/export.dart' hide Order;

extension Precision on double {
  double toPrecision(num fractionDigits) {
    final double mod = pow(10, fractionDigits).toDouble();
    return (this * mod).round().toDouble() / mod;
  }
}

Future successMessage(BuildContext context, String msg, {Duration duration= const Duration(seconds: 2)}) => Flushbar(
    duration: duration,
    backgroundColor: Colors.green,
    message: msg
).show(context);

Future errorMessage(BuildContext context, String msg) => Flushbar(
    duration: const Duration(seconds: 4),
    backgroundColor: Colors.redAccent,
    message: msg
).show(context);
