import Alamofire
import Foundation

protocol BaseService: NetworkService {
    var baseURL: String { get }
    var apiVersion: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var bodyEncoding: ParameterEncoding { get }
    var parameters: [String: Any] { get }

    func getRequest() -> URL?
}

extension BaseService {
    var baseURL: String {
        "https://gateway.marvel.com/\(apiVersion)/public"
    }

    var apiVersion: String {
        "v1"
    }

    var method: HTTPMethod {
        .get
    }

    var contentType: String {
        return "application/json; charset=utf-8"
    }

    var headers: [String: String] {
        return ["Content-type": contentType]
    }

    var bodyEncoding: ParameterEncoding {
        JSONEncoding.default
    }

    func getRequest() -> URL? {
        URL(string: baseURL + path + genericPath())
    }

    var parameters: [String : Any] {
        return [:]
    }

    private func genericPath() -> String {
        do {
            let marvelParamaters = try MarvelParamatersLoader().load()
            let conditionMirror = Mirror(reflecting: marvelParamaters)
            var path = ""
            for (key,value) in conditionMirror.children  {
                if let key = key {
                    path.append(contentsOf: "&" + String(describing: key) + "=" + String(describing: value))
                }
            }
            return path
        } catch {
            fatalError("Please check if required parametrs are present in Plist file")
        }
    }
}

