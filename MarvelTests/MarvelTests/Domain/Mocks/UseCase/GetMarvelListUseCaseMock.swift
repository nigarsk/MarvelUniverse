@testable import Marvel

final class GetMarvelListUseCaseMock: GetMarvelListUseCaseContract {
    var marvelListResult: MarvelListResponse!

    init(mockListResponse: MarvelListResponse) {
        self.marvelListResult = mockListResponse
    }

    func run(configModel: MarvelListRequestModel, completion: @escaping Completion) {
        guard let mockListResponse = marvelListResult else {
            fatalError("Mock response required")
        }
        completion(mockListResponse)
    }
}
