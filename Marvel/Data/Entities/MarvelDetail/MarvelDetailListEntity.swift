struct MarvelDetailListEntity: Codable {
    var offset: Int?
    var total: Int?
    var results: [MarvelDetailEntity]?
}

struct MarvelDetailDataEntity: Codable {
    var data: MarvelDetailListEntity?
}
