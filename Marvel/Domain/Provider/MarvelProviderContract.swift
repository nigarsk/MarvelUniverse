protocol MarvelProviderContract {
    typealias MarvelCharacterListCompletion = (_ result: Result<MarvelListModel, UseCaseError>) -> Void
    typealias MarvelCharacterDetailsCompletion = (_ result: Result<MarvelDetailModel, UseCaseError>) -> Void
    
    func getMarvelCharacterList(configModel: MarvelListRequestModel, completion: @escaping MarvelCharacterListCompletion)
    func getMarvelCharacterDetail(id: Int, completion: @escaping MarvelCharacterDetailsCompletion)
}
