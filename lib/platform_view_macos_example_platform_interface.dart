import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'platform_view_macos_example_method_channel.dart';

abstract class PlatformViewMacosExamplePlatform extends PlatformInterface {
  /// Constructs a PlatformViewMacosExamplePlatform.
  PlatformViewMacosExamplePlatform() : super(token: _token);

  static final Object _token = Object();

  static PlatformViewMacosExamplePlatform _instance = MethodChannelPlatformViewMacosExample();

  /// The default instance of [PlatformViewMacosExamplePlatform] to use.
  ///
  /// Defaults to [MethodChannelPlatformViewMacosExample].
  static PlatformViewMacosExamplePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformViewMacosExamplePlatform] when
  /// they register themselves.
  static set instance(PlatformViewMacosExamplePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
