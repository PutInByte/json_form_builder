import 'package:flutter/material.dart';
import 'package:json_form_builder/src/core/utils/typedefs.dart';

class BuilderEventConfig {

  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  final VoidCallback? onBuild;
  final ChangedEvent? onChangedPager;
  final ChangedEvent? onChangeContent;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onEnd;
  final VoidCallback? onStart;
  final ServerSideEvent? serverSideEvent;

  const BuilderEventConfig({
    this.onInit,
    this.onDispose,
    this.onBuild,
    this.onChangedPager,
    this.onChangeContent,
    this.onNext,
    this.onPrevious,
    this.onEnd,
    this.onStart,
    this.serverSideEvent,
  });

}

