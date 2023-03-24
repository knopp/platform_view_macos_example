import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform_view_macos_example/platform_view_macos_example_method_channel.dart';

void main() {
  MethodChannelPlatformViewMacosExample platform = MethodChannelPlatformViewMacosExample();
  const MethodChannel channel = MethodChannel('platform_view_macos_example');

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
