import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_form_builder/json_form_builder_method_channel.dart';

void main() {
  MethodChannelJsonFormBuilder platform = MethodChannelJsonFormBuilder();
  const MethodChannel channel = MethodChannel('json_form_builder');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
