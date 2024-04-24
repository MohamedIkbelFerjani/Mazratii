import UIKit
import Flutter
import flutter_local_notification
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
GeneratedPluginRegistrant.register(with: registry)}
    GeneratedPluginRegistrant.register(with: self)
    if #avaible(iOS 10.0,*){
      UNUserNotificationCebter.current().delegate = self as? UNUserNotificationCebter
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
