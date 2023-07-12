import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let APIKEY = KeyManager().getValue(key: "googleMapAPIKey") as? String {
      GMSServices.provideAPIKey(APIKEY)
    }

    GeneratedPluginRegistrant.register(with: self)

    /// 設定画面を開くための設定
    let methodChannelName = "openSetting"
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let settingsChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: controller as! FlutterBinaryMessenger)
    settingsChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if (call.method == "openSetting") {
        let url = URL(string: "App-Prefs:root")
        let app = UIApplication.shared
        result(app.openURL(url!))
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
