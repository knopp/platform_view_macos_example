
import 'platform_view_macos_example_platform_interface.dart';

class PlatformViewMacosExample {
  Future<String?> getPlatformVersion() {
    return PlatformViewMacosExamplePlatform.instance.getPlatformVersion();
  }
}
