import UIKit
import Flutter
import Appboy_iOS_SDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    Appboy.start(withApiKey: "REPLACE_WITH_YOUR_API_KEY", in:application, withLaunchOptions:launchOptions)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
