@testable import Marvel

extension MarvelListModel {
    static func dummyModel() -> MarvelListModel {
        MarvelListModel(offset: 0,
                         total: 20,
                         items: [MarvelItemModel.dummyModel()])
    }
}
