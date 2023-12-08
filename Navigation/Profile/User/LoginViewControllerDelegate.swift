import UIKit


protocol LoginViewControllerDelegate {
    func check (log: String, pass: String) -> Bool
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(log: String, pass: String) -> Bool {
        return Checker.checker.check(log: log, pass: pass)
    }
}

struct MyLogInFactory: LoginFactory {
    
    private let inspector =  LoginInspector()
    
    func makeLoginInspector() -> LoginInspector {
        return inspector
    }
}

