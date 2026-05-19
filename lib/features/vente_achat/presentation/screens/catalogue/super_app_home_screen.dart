import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../va_shell_screen.dart';

@RoutePage()
class SuperAppHomeScreen extends StatelessWidget {
  const SuperAppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const VAShellScreen();
}
