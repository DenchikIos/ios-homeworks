import Foundation


enum NetworkError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case decodeError = 1000
    case serverError = 500
    case unowned = 2000
}

