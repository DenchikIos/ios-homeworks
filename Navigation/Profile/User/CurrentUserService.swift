import UIKit

class CurrentUserService: UserService {
    
    let currentUser = User(userLogin: "iosDeveloper", userFullName: "Denis", userAvatar: UIImage(named: "avatar") ?? UIImage(), userStatus: "Learning is light and ignorance is darkness")
    
    func authorization(userLogin: String) -> User? {
        let user = userLogin == currentUser.userLogin ? currentUser : nil
       return user
    }
}
