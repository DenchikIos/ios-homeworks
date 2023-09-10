
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let feedViewController = FeedViewController()
        feedViewController.title = "Feed"
        feedViewController.view.backgroundColor = .systemMint
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.richtext"), tag: 0)
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        profileViewController.view.backgroundColor = .systemCyan
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .systemGray
        
        let controllers = [feedViewController, profileViewController]
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)
        }
        
        tabBarController.selectedIndex = 0
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
    
    
