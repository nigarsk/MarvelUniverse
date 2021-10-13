import Foundation

struct MarvelDetailEntity: Codable {
    var id: Int?
    var name: String?
    var thumbnail: String?
    var path: String?
    var `extension`: String?
    var description: String?

    func toDomain() throws -> MarvelDetailModel {
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
        return MarvelDetailModel(marvelId: id,
                                 marvelName: name,
                                 marvelDescription: description ?? "",
                                 marvelURL: thumbNailURL)
    }
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumbnail
        case path
        case `extension`
        case description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let thumbnail = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnail)
        path = try thumbnail.decode(String.self, forKey: .path)
        `extension` = try thumbnail.decode(String.self, forKey: .`extension`)
        description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}
