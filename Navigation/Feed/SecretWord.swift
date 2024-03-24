import Foundation

struct SecretWord {
    let secretWord: String
}

final class SecretWords {
    
    private let secretWords = [
        SecretWord(secretWord: "Developer")
        ]
    
    func todayIsSecretWord() -> String {
        guard let randomElement = secretWords.randomElement() else {
            return "error"
        }
        return randomElement.secretWord
    }
    
}
