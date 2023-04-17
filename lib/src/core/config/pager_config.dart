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
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.parentPhysics = const NeverScrollableScrollPhysics(),
    this.childrenPhysics = const ClampingScrollPhysics(),
    this.keepAlive = true,
    this.borderRadius = 10,
    this.alignment = Alignment.topCenter,
  });


}