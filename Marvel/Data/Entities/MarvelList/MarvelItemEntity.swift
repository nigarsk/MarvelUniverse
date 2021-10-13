import Foundation

struct MarvelItemEntity: Codable {
    var id: Int?
    var name: String?
    var thumbnail: String?
    var path: String?
    var `extension`: String?

    func toDomain() throws -> MarvelItemModel {
        guard let id = id else {
            let error = EncodingError.Context(codingPath: [],
                                              debugDescription: "Invalid id")
            throw EncodingError.invalidValue(id ?? 0, error)
        }
        guard let name = name else {
            let error = EncodingError.Context(codingPath: [],
                                              debugDescription: "Invalid name")
            throw EncodingError.invalidValue(name ?? "", error)
        }
        let thumbNailURLString = (path ?? "") + "." + (`extension` ?? "")
        let thumbNailURL = URL(string: thumbNailURLString)
        return MarvelItemModel(marvelId: id,
                               marvelName: name,
                               marvelURL: thumbNailURL)
    }
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumbnail
        case path
        case `extension`
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let thumbnail = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnail)
        path = try thumbnail.decode(String.self, forKey: .path)
        `extension` = try thumbnail.decode(String.self, forKey: .`extension`)
    }
}
