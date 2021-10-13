protocol GetMarvelDetailUseCaseContract {
    typealias Completion = (_ result: Result<MarvelDetailModel, UseCaseError>) -> Void

    func run(id: Int, completion: @escaping Completion)
}

class GetMarvelDetailsUseCase: GetMarvelDetailUseCaseContract {
    private let provider: MarvelProviderContract = MarvelProvider()

    func run(id: Int, completion: @escaping Completion) {
        provider.getMarvelCharacterDetail(id: id, completion: completion)
    }
}
