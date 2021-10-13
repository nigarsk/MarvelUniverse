@testable import Marvel

extension MarvelDetailModel {
    static func dummyModel() -> MarvelDetailModel {
        return MarvelDetailModel(marvelId: 2,
                                 marvelName: "Hulk",
                                 marvelDescription: "Strong",
                                 marvelURL: nil)
    }
}
