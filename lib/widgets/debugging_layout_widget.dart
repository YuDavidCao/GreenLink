import 'package:flutter/material.dart';
import 'package:solar_web/constants.dart';

class DebuggingLayoutWidget extends StatelessWidget {
  final Widget? child;
  final Color? color;
  const DebuggingLayoutWidget({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (globalDebuggerFlag)
          ? BoxDecoration(border: Border.all(color: color ?? Colors.black))
          : null,
      child: child,
    );
  }
}
