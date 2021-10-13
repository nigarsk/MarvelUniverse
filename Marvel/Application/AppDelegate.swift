import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        presentInitialScreen(in: window)
        return true
    }

    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window else { return }
        self.window = window
        Navigator.shared.show(segue: .marvel, sender: nil, transition: .root(in: window))
    }
}

