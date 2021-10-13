import Foundation

enum UseCaseError: Error {
    case generic(Error)
    case mappingError
    case apiError
    case unknown
}

extension NetworkError {
    func useCaseError() -> UseCaseError {
        switch self {
        case .inValidUrl, .invalidResponse, .noData:
            return .apiError
        case let .generic(error):
            return .generic(error)
        default:
            return .unknown
        }
    }
}
