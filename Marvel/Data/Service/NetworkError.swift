import Alamofire
import Foundation

enum NetworkError: Error {
    case generic(Error)
    case inValidUrl
    case invalidResponse
    case noData
    case unknown
}

extension AFError {
    func networkError() -> NetworkError {
        if self.isInvalidURLError {
            return .inValidUrl
        }
        if self.isResponseSerializationError || self.isResponseValidationError {
            return .invalidResponse
        }
        if let underLyingError = self.underlyingError {
            return .generic(underLyingError)
        }
        return .unknown
    }
}
