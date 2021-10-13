@testable import Marvel

final class GetMarvelDetailsUseCaseMock: GetMarvelDetailUseCaseContract {
    var marvelDetailResult: MarvelDetailsResponse!

    init(mockDetailsResponse: MarvelDetailsResponse) {
        self.marvelDetailResult = mockDetailsResponse
    }

    func run(id: Int, completion: @escaping Completion) {
        guard let mockDetailsResponse = marvelDetailResult else {
            fatalError("Mock response required")
        }
        completion(mockDetailsResponse)
    }
}
