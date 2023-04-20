import 'package:flutter/material.dart';

class PagerConfig {

  final Duration animationDuration;

  final Curve animationCurve;

  final ScrollPhysics parentPhysics;

  final ScrollPhysics childrenPhysics;

  final bool keepAlive;

  final Alignment alignment;

  final double borderRadius;

  const PagerConfig({
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.parentPhysics = const NeverScrollableScrollPhysics(),
    this.childrenPhysics = const NeverScrollableScrollPhysics(),
    this.keepAlive = true,
    this.borderRadius = 10,
    this.alignment = Alignment.topCenter,
  });

}