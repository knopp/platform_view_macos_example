import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:platform_view_macos_example/platform_view_macos_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _platformViewMacosExamplePlugin = PlatformViewMacosExample();

  double opacity = 1.0;
  double radius = 30;
  double scale = 0.75;
  double angle = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _platformViewMacosExamplePlugin.getPlatformVersion() ??
              'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget version = Text('Running on: $_platformVersion\n');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PlatformView Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              version,
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Text("A flutter widget at the bottom!",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.red)),
                  DeformableNativeView(
                    angle: -math.pi / 180 * angle,
                    opacity: opacity,
                    radius: radius,
                    scale: scale,
                  ),
                  Opacity(
                    opacity: 0.75,
                    child: Container(
                      constraints: const BoxConstraints.expand(
                        height: 75,
                        width: 350,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.blue[600],
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(0.2),
                      child: Text("A flutter widget at the top!",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Opacity'),
                  Slider(
                    value: opacity,
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    activeColor: Colors.greenAccent,
                    label: opacity.toString(),
                    onChanged: (double value) {
                      setState(() {
                        opacity = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Rotate'),
                  Slider(
                    value: angle,
                    min: 0.0,
                    max: 360.0,
                    divisions: 72,
                    activeColor: Colors.greenAccent,
                    label: angle.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        angle = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Radius'),
                  Slider(
                    value: radius,
                    min: 0.0,
                    max: 100.0,
                    divisions: 10,
                    activeColor: Colors.greenAccent,
                    label: radius.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        radius = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Scale'),
                  Slider(
                    value: scale,
                    min: 0.0,
                    max: 1.5,
                    divisions: 15,
                    activeColor: Colors.greenAccent,
                    label: scale.toString(),
                    onChanged: (double value) {
                      setState(() {
                        scale = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
