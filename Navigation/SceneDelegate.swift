import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let loginFactory = MyLogInFactory()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        func createFeedViewController() -> UINavigationController {
            let feedViewController = FeedViewController()
            feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.richtext"), tag: 0)
            return UINavigationController(rootViewController: feedViewController)
        }
        
        func createProfileViewController() -> UINavigationController {
            let profileViewController = LogInViewController()
            profileViewController.loginDelegate = loginFactory.makeLoginInspector()
            profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
            return UINavigationController(rootViewController: profileViewController)
        }
        
        func createTabBarController() -> UITabBarController {
            let tabBarController = UITabBarController()
            UITabBar.appearance().backgroundColor = .systemGray3
            tabBarController.viewControllers = [createFeedViewController(), createProfileViewController()]
            tabBarController.selectedIndex = 0
            return tabBarController
        }
        
        window.rootViewController = createTabBarController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
