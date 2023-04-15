import 'package:flutter/material.dart';
import 'package:json_form_builder/json_form_builder.dart';

class BuilderEventConfig {

  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  final VoidCallback? onBuild;
  final VoidCallback? onChangePager;
  final VoidCallback? onChangeContent;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onEnd;
  final VoidCallback? onStart;

  final OnNextServerSide? onNextServerSide;


  const BuilderEventConfig({
    this.onInit,
    this.onDispose,
    this.onBuild,
    this.onChangePager,
    this.onChangeContent,
    this.onNext,
    this.onPrevious,
    this.onEnd,
    this.onStart,

    this.onNextServerSide,
  });

}

