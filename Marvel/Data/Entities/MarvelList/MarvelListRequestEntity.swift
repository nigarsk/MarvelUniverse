struct MarvelListRequestEntity {
    let offset: Int
    let limit: Int

    init(configModel: MarvelListRequestModel) {
        offset = configModel.offset
        limit = configModel.limit
    }
}
