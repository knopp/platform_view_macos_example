import Cocoa
import FlutterMacOS

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withViewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> NSView {
        return FLNativeView(
            frame: CGRect(x: 0, y: 0, width: 200, height: 200),
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

public func createLabel() -> NSTextField {
    let nativeLabel = NSTextField()
    nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
    nativeLabel.stringValue = "Native text from macOS"
    nativeLabel.textColor = NSColor.red
    nativeLabel.isBezeled = false
    nativeLabel.isEditable = false
    nativeLabel.sizeToFit()
    return nativeLabel
}

class FLNativeView: NSView {

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        super.init(frame: frame)
        super.wantsLayer = true
        super.layer?.backgroundColor = NSColor.blue.cgColor
        super.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        super.addSubview(createLabel())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.wantsLayer = true
        super.layer?.backgroundColor = NSColor.blue.cgColor
        super.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        super.addSubview(createLabel())
    }

    override func mouseDown(with event: NSEvent) {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0.5...1)
        let randomColor = NSColor(red: red, green: green, blue: blue, alpha: alpha)
        super.layer?.backgroundColor = randomColor.cgColor
    }
}

public class PlatformViewMacosExamplePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_view_macos_example", binaryMessenger: registrar.messenger)
    let instance = PlatformViewMacosExamplePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    let factory = FLNativeViewFactory(messenger: registrar.messenger)
    registrar.register(factory, withId: "@views/simple-box-view-type")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
