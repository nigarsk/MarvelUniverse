import Foundation

final class MarvelParamatersLoader: MarvelParamatersProtocol {
    private lazy var decoder = PropertyListDecoder()

    required init() {}

    func load() throws -> MarvelParamatersEntity {
        let bundle = Bundle(for: type(of: self))
        return try load(bundle: bundle, fileManager: .default, decoder: decoder)
    }

    private func load(bundle: Bundle,
                      fileManager: FileManager,
                      decoder: PropertyListDecoder) throws -> MarvelParamatersEntity {
        guard let path = bundle.path(forResource: "MarvelParameters", ofType: "plist") else {
            throw CocoaError(.fileNoSuchFile)
        }
        guard let data = fileManager.contents(atPath: path) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        return try decoder.decode(MarvelParamatersEntity.self, from: data)
    }
}
