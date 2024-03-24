import Foundation


enum NetworkError: Error {
    case badRequest
    case unauthorized
    case notFound
    case serverError
    case unowned
    case decodeError
}
