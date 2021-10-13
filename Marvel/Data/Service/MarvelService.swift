import Foundation

enum MarvelServiceType {
    case getMarvelList(requestEntity: MarvelListRequestEntity)
    case getMarvelDetail(id: Int)
}

final class MarvelService: MarvelServiceProtocol {
    var serviceType: MarvelServiceType

    var path: String {
        switch serviceType {
        case .getMarvelList(let requestEntity):
            return "/characters?offset=\(requestEntity.offset)&limit=\(requestEntity.limit)&"
        case .getMarvelDetail(let id):
            return "/characters/\(id)?"
        }
    }

    init(serviceType: MarvelServiceType) {
        self.serviceType = serviceType
    }
}
