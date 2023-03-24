import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'platform_view_macos_example_platform_interface.dart';

/// An implementation of [PlatformViewMacosExamplePlatform] that uses method channels.
class MethodChannelPlatformViewMacosExample extends PlatformViewMacosExamplePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('platform_view_macos_example');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
