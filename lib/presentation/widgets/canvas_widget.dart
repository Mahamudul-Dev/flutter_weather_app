import 'package:flutter/material.dart';

import '../../data/utils/utils.dart';

class CanvasWidget extends StatelessWidget {
  const CanvasWidget({super.key, required this.layout, this.child});

  final Size layout;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: layout.height,
        width: layout.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Config.BG_BLUE_LIGHT, Config.BG_BLUE_DARK],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      ),
    );
  }
}
