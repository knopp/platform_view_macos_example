import 'platform_view_macos_example_platform_interface.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformViewMacosExample {
  Future<String?> getPlatformVersion() {
    return PlatformViewMacosExamplePlatform.instance.getPlatformVersion();
  }
}

class NSBox extends StatelessWidget {
  const NSBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '@views/simple-box-view-type';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

class DeformableNativeView extends StatefulWidget {
  const DeformableNativeView(
      {required this.angle,
      required this.opacity,
      required this.radius,
      required this.scale,
      Key? key})
      : super(key: key);
  final double opacity;
  final double radius;
  final double angle;
  final double scale;

  @override
  State<DeformableNativeView> createState() => _DeformableNativeViewState();
}

class _DeformableNativeViewState extends State<DeformableNativeView> {
  final _childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      color: Colors.green,
      child: Transform.rotate(
        angle: 0.5, // Rotate child relative to clip rect
        child: SizedBox(
          key: _childKey,
          height: 300,
          width: 300,
          child: const NSBox(),
        ),
      ),
    );
    if (widget.radius == 0) {
      child = ClipRect(child: child);
    } else {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: child,
      );
    }
    return Transform.rotate(
      angle: widget.angle,
      child: Transform.scale(
        scale: widget.scale,
        child: Opacity(
          opacity: widget.opacity,
          child: child,
        ),
      ),
    );
  }
}
