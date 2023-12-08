import UIKit


final class Checker {
    
    private let login: String = "iosDeveloper"
    private let password: String = "09061992"
    
    static let checker = Checker()
    
    private init () {}
    
    
    func check (log: String, pass: String) -> Bool {
        guard log == login && pass == password else { return false }
        return true
    }
}
