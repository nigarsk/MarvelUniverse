protocol GetMarvelListUseCaseContract {
    typealias Completion = (_ result: Result<MarvelListModel, UseCaseError>) -> Void

    func run(configModel: MarvelListRequestModel, completion: @escaping Completion)
}

class GetMarvelListUseCase: GetMarvelListUseCaseContract {
    private let provider: MarvelProviderContract = MarvelProvider()

    func run(configModel: MarvelListRequestModel, completion: @escaping Completion) {
        provider.getMarvelCharacterList(configModel: configModel, completion: completion)
    }
}
