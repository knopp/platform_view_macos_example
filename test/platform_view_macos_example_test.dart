import 'package:flutter_test/flutter_test.dart';
import 'package:platform_view_macos_example/platform_view_macos_example.dart';
import 'package:platform_view_macos_example/platform_view_macos_example_platform_interface.dart';
import 'package:platform_view_macos_example/platform_view_macos_example_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPlatformViewMacosExamplePlatform
    with MockPlatformInterfaceMixin
    implements PlatformViewMacosExamplePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PlatformViewMacosExamplePlatform initialPlatform = PlatformViewMacosExamplePlatform.instance;

  test('$MethodChannelPlatformViewMacosExample is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPlatformViewMacosExample>());
  });

  test('getPlatformVersion', () async {
    PlatformViewMacosExample platformViewMacosExamplePlugin = PlatformViewMacosExample();
    MockPlatformViewMacosExamplePlatform fakePlatform = MockPlatformViewMacosExamplePlatform();
    PlatformViewMacosExamplePlatform.instance = fakePlatform;

    expect(await platformViewMacosExamplePlugin.getPlatformVersion(), '42');
  });
}
