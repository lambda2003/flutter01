import Flutter
import UIKit
// ADDED BY GT (notification)
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // ADDED BY GT (notification)
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }

    // Original Source
    GeneratedPluginRegistrant.register(with: self)


    // ADDED BY GT (notification)
    // IOS Foreground 푸시 수신
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
