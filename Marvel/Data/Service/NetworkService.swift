import Alamofire
import Foundation

protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void

    func request(endpoint: BaseService, completion: @escaping CompletionHandler)
}

extension NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void

    func request(endpoint: BaseService, completion: @escaping CompletionHandler) {
        guard let url = endpoint.getRequest() else {
            completion(.failure(.inValidUrl))
            return
        }
        let httpHeaders = HTTPHeaders(endpoint.headers)
        AF.request(url, method: endpoint.method, parameters: endpoint.parameters, headers: httpHeaders)
            .validate()
            .responseData { response in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error.networkError()))
            }
        }
    }
}
