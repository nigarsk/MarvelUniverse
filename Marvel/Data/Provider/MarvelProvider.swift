import Foundation

protocol MarvelServiceProtocol: BaseService {}

final class MarvelProvider: MarvelProviderContract {
    var service: MarvelServiceProtocol!

    convenience init(service: MarvelServiceProtocol) {
        self.init()
        self.service = service
    }

    private func setServiceType(serviceType: MarvelServiceType) {
        guard service == nil else {
            return
        }
        self.service = MarvelService(serviceType: serviceType)
    }
    
    func getMarvelCharacterList(configModel: MarvelListRequestModel, completion: @escaping MarvelCharacterListCompletion) {
        let requestEntity = MarvelListRequestEntity(configModel: configModel)
        let serviceType = MarvelServiceType.getMarvelList(requestEntity: requestEntity)
        setServiceType(serviceType: serviceType)
        service.request(endpoint: service) { response in
            switch response {
            case .success(let data):
                guard let response = data else {
                    completion(.failure(.apiError))
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let marvelListEntity = try decoder.decode(MarvelEntity.self, from: response)
                    guard let model = try marvelListEntity.data?.toDomain() else {
                        completion(.failure(.mappingError))
                        return
                    }
                    completion(.success(model))
                } catch {
                    completion(.failure(.mappingError))
                }
            case .failure(let error):
                completion(.failure(error.useCaseError()))
            }
        }
    }

    func getMarvelCharacterDetail(id: Int, completion: @escaping MarvelCharacterDetailsCompletion) {
        let serviceType = MarvelServiceType.getMarvelDetail(id: id)
        setServiceType(serviceType: serviceType)

        service.request(endpoint: service) { response in
            switch response {
            case .success(let data):
                guard let response = data else {
                    completion(.failure(.apiError))
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let marvelListEntity = try decoder.decode(MarvelDetailDataEntity.self, from: response)
                    guard let model = marvelListEntity.data?.results?.first else {
                        completion(.failure(.mappingError))
                        return
                    }
                    let domainModel = try model.toDomain()
                    completion(.success(domainModel))
                } catch {
                    completion(.failure(.mappingError))
                }
            case .failure(let error):
                completion(.failure(error.useCaseError()))
            }
        }
    }
}
