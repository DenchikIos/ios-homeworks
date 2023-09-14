import UIKit

class ProfileViewController: UIViewController {
      
    override func viewDidLoad() {
            super.viewDidLoad()
        view.backgroundColor = .lightGray
        
    }
    
    let profileHeaderView = ProfileHeaderView()
    
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = view.frame
    }
}
