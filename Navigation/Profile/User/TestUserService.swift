import UIKit

class TestUserService: UserService {
    
    let testUser = User(userLogin: "test", userFullName: "test", userAvatar: UIImage(systemName: "person.circle") ?? UIImage(), userStatus: "test")
    
    func authorization(userLogin: String) -> User? {
        let test = userLogin == testUser.userLogin ? testUser : nil
        return test
    }
}
