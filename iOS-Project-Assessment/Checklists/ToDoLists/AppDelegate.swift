import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
    
    let lists = ListsModel()

    func updateDataModel() {
        lists.saveLists()
    }

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationController = window!.rootViewController
                                   as! UINavigationController
        let vc = navigationController.viewControllers[0]
                                   as! MainViewController
        vc.listModel = lists
        
		return true
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		updateDataModel()
	}

	func applicationWillTerminate(_ application: UIApplication) {
		updateDataModel()
	}
}
