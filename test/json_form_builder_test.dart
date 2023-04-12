import 'package:flutter_test/flutter_test.dart';
import 'package:json_form_builder/json_form_builder.dart';
import 'package:json_form_builder/json_form_builder_platform_interface.dart';
import 'package:json_form_builder/json_form_builder_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockJsonFormBuilderPlatform
    with MockPlatformInterfaceMixin
    implements JsonFormBuilderPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final JsonFormBuilderPlatform initialPlatform = JsonFormBuilderPlatform.instance;

  test('$MethodChannelJsonFormBuilder is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJsonFormBuilder>());
  });

  test('getPlatformVersion', () async {
    JsonFormBuilder jsonFormBuilderPlugin = JsonFormBuilder();
    MockJsonFormBuilderPlatform fakePlatform = MockJsonFormBuilderPlatform();
    JsonFormBuilderPlatform.instance = fakePlatform;

    expect(await jsonFormBuilderPlugin.getPlatformVersion(), '42');
  });
}
