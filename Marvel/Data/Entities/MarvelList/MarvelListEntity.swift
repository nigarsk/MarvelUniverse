struct MarvelListEntity: Codable {
    var offset: Int?
    var total: Int?
    var results: [MarvelItemEntity]?

    func toDomain() throws -> MarvelListModel {
        guard let offset = offset else {
            let error = EncodingError.Context(codingPath: [],
                                              debugDescription: "Invalid offset")
            throw EncodingError.invalidValue(offset ?? 0, error)
        }
        guard let total = total else {
            let error = EncodingError.Context(codingPath: [],
                                              debugDescription: "Invalid total")
            throw EncodingError.invalidValue(total ?? 0, error)
        }
        let models = results?.compactMap({ entity in
            return try? entity.toDomain()
        }) ?? []
        return MarvelListModel(offset: offset, total: total, items: models)
    }
}

struct MarvelEntity: Codable {
    var data: MarvelListEntity?
}
