import Foundation

struct MarvelListModel: Equatable {
    let offset: Int
    let total: Int
    let items: [MarvelItemModel]
}
