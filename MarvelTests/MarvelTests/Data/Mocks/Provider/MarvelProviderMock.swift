@testable import Marvel

typealias MarvelListResponse = Result<MarvelListModel, UseCaseError>
typealias MarvelDetailsResponse = Result<MarvelDetailModel, UseCaseError>

final class MarvelProviderMock: MarvelProviderContract {
    private var mockListResponse: MarvelListResponse!
    private var mockDetailsResponse: MarvelDetailsResponse!

    init(mockListResponse: MarvelListResponse) {
        self.mockListResponse = mockListResponse
    }

    init(mockDetailsResponse: MarvelDetailsResponse) {
        self.mockDetailsResponse = mockDetailsResponse
    }

    func getMarvelCharacterList(configModel: MarvelListRequestModel, completion: @escaping MarvelCharacterListCompletion) {
        guard let mockListResponse = mockListResponse else {
            fatalError("mock required")
        }
        completion(mockListResponse)
    }

    func getMarvelCharacterDetail(id: Int, completion: @escaping MarvelCharacterDetailsCompletion) {
        guard let mockDetailsResponse = mockDetailsResponse else {
            fatalError("mock required")
        }
        completion(mockDetailsResponse)
    }
}
