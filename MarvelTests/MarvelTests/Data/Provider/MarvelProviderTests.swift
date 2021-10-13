import XCTest
import Alamofire

@testable import Marvel

typealias CompletionStub = Result<Data?, NetworkError>
private final class MarvelServiceMock: MarvelServiceProtocol {
    var completionStub: CompletionStub

    init(completionStub: CompletionStub) {
        self.completionStub = completionStub
    }

    var path: String {
        "http://mock.test.com"
    }

    var parameters: [String : Any] {
        [:]
    }

    var bodyEncoding: ParameterEncoding {
        JSONEncoding.default
    }

    func request(endpoint: BaseService, completion: @escaping CompletionHandler) {
        completion(completionStub)
    }
}

class MarvelsProviderTests: XCTestCase {
    var provider: MarvelProvider!

    private func marvelsProvider(mockResponse: CompletionStub) -> MarvelProvider {
        MarvelProvider(service: MarvelServiceMock(completionStub: mockResponse))
    }


    func testFetchMarvelListForSuccess() {
        let success = expectation(description: "success")
        let configModel = MarvelListRequestModel(offset: 0, limit: 20)
        let mockData = getMock(name: "MarvelList")
        provider = marvelsProvider(mockResponse: .success(mockData))
        provider.getMarvelCharacterList(configModel: configModel) { result in
            if case .success = result {
                success.fulfill()
            }
        }
        wait(for: [success], timeout: 5)
    }

    func testFetchMarvelListForFailure() {
        let success = expectation(description: "success")
        let configModel = MarvelListRequestModel(offset: 0, limit: 20)
        provider = marvelsProvider(mockResponse: .failure(.invalidResponse))
        provider.getMarvelCharacterList(configModel: configModel) { result in
            if case .failure = result {
                success.fulfill()
            }
        }
        wait(for: [success], timeout: 5)
    }

    func testFetchMarvelDetailsForSuccess() {
        let success = expectation(description: "success")
        let mockData = getMock(name: "MarvelList")
        provider = marvelsProvider(mockResponse: .success(mockData))
        provider.getMarvelCharacterDetail(id: 1) { result in
            if case .success = result {
                success.fulfill()
            }
        }
        wait(for: [success], timeout: 5)
    }

    func testFetchMarvelDetailsForFailure() {
        let success = expectation(description: "success")
        provider = marvelsProvider(mockResponse: .failure(.invalidResponse))
        provider.getMarvelCharacterDetail(id: 1) { result in
            if case .failure = result {
                success.fulfill()
            }
        }
        wait(for: [success], timeout: 5)
    }
}

extension MarvelsProviderTests {
    func getMock(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: name, ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            XCTFail("Mock not found")
            return nil
        }
        return jsonData
    }
}
