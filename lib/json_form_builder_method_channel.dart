import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'json_form_builder_platform_interface.dart';

/// An implementation of [JsonFormBuilderPlatform] that uses method channels.
class MethodChannelJsonFormBuilder extends JsonFormBuilderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('json_form_builder');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
