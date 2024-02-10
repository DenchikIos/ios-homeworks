import Foundation

final class CurrentUserService: UserService {

    let currentUser = User(userFullName: "Cat", userAvatar: "avatar", userStatus: "Enter status")
    
    func authorization() -> User? {
            return currentUser
        }
    
}
