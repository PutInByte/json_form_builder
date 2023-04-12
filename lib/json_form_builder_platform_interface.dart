import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'json_form_builder_method_channel.dart';

abstract class JsonFormBuilderPlatform extends PlatformInterface {
  /// Constructs a JsonFormBuilderPlatform.
  JsonFormBuilderPlatform() : super(token: _token);

  static final Object _token = Object();

  static JsonFormBuilderPlatform _instance = MethodChannelJsonFormBuilder();

  /// The default instance of [JsonFormBuilderPlatform] to use.
  ///
  /// Defaults to [MethodChannelJsonFormBuilder].
  static JsonFormBuilderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JsonFormBuilderPlatform] when
  /// they register themselves.
  static set instance(JsonFormBuilderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
